#encoding: utf-8

class PedidosController < ApplicationController
  before_filter :autenticado
  before_filter :usuario_correcto, only: [:show, :edit, :update]

  # GET /pedidos
  # GET /pedidos.json
  def index
    @pedidos = usuario_actual.pedidos.order('created_at desc')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pedidos }
    end
  end

  # GET /pedidos/1
  # GET /pedidos/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pedido }
    end
  end

  # GET /pedidos/new
  # GET /pedidos/new.json
  def new
    @pedido = Pedido.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pedido }
    end
  end

  # GET /pedidos/1/edit
  def edit
  end

  # POST /pedidos
  # POST /pedidos.json
  def create
    @pedido = Pedido.new(params[:pedido])

    respond_to do |format|
      if @pedido.save
        Item.where(usuario_id: usuario_actual.id).update_all(pedido_id: @pedido.id)
        format.html { redirect_to @pedido, notice: 'Pedido was successfully created.' }
        format.json { render json: @pedido, status: :created, location: @pedido }
      else
        format.html { render action: "new" }
        format.json { render json: @pedido.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pedidos/1
  # PUT /pedidos/1.json
  def update
    respond_to do |format|
      if @pedido.update_attributes(params[:pedido])
        format.html { redirect_to @pedido, notice: 'Pedido was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pedido.errors, status: :unprocessable_entity }
      end
    end
  end

private

  def autenticado
    unless identificado?
      redirect_to root_path
    end
  end

  def usuario_correcto
    @pedido = Pedido.find(params[:id])
    unless usuario_actual.admin? || (usuario_actual?(@pedido.usuario))
      redirect_to root_path
    end
  end
end
