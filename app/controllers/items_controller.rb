#encoding: utf-8

class ItemsController < ApplicationController
  # GET /items
  # GET /items.json
  def index
    if identificado?
      @items = usuario_actual.items.en_carrito
    else
      session[:guest_token] ||= SecureRandom.urlsafe_base64
      @items = Item.where(guest_token: session[:guest_token]).en_carrito
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  def new
    @item = Item.new
    @producto = Producto.find(params[:producto])
    unless identificado?
      session[:guest_token] ||= SecureRandom.urlsafe_base64
    end

    respond_to do |format|
      format.html { render layout: false }
      format.json { render json: @items }
    end
  end

  # POST /items
  # POST /items.json
  def create

    if identificado?
      @item = Item.where(producto_id: params[:item][:producto_id], usuario: usuario_actual).first_or_initialize
    else
      session[:guest_token] ||= SecureRandom.urlsafe_base64
      @item = Item.where(producto_id: params[:item][:producto_id],guest_token: session[:guest_token]).first_or_initialize
    end

     @item.cantidad ||= 0
     @item.cantidad += params[:item][:cantidad].to_i
    respond_to do |format|
      if @item.save
        format.json { render json: @item, status: :created, location: @item }
      else
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])
    if (identificado? && usuario_actual?(@item.usuario)) || (@item.guest_token == session[:guest_token])
      respond_to do |format|
        if @item.update_attributes(params[:item])
          format.json { render json: @item }
        else
          format.json { render json: @item.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    if (identificado? && usuario_actual?(@item.usuario)) || (@item.guest_token == session[:guest_token])
      @item.destroy

      respond_to do |format|
        format.html { redirect_to items_url }
        format.json { head :no_content }
      end
    else
      redirect_to root_path
    end 
  end
end
