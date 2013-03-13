class CategoriasController < ApplicationController
  before_filter :administrar, only: [:new, :edit, :delete, :update, :create]
  before_filter :limpiar_opciones, only: [:update, :create]
  # GET /categorias
  # GET /categorias.json
  def index
    @categorias = Categoria.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categorias }
    end
  end

  # GET /categorias/1
  # GET /categorias/1.json
  def show
    @categoria = Categoria.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @categoria }
    end
  end

  # GET /categorias/new
  # GET /categorias/new.json
  def new
    @categoria = Categoria.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @categoria }
    end
  end

  # GET /categorias/1/edit
  def edit
    @categoria = Categoria.find(params[:id])
  end

  # POST /categorias
  # POST /categorias.json
  def create
    @categoria = Categoria.new(params[:categoria])

    respond_to do |format|
      if @categoria.save
        format.html { redirect_to @categoria, notice: 'Categoria was successfully created.' }
        format.json { render json: @categoria, status: :created, location: @categoria }
      else
        format.html { render action: "new" }
        format.json { render json: @categoria.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /categorias/1
  # PUT /categorias/1.json
  def update
    @categoria = Categoria.find(params[:id])

    respond_to do |format|
      if @categoria.update_attributes(params[:categoria])
        format.html { redirect_to @categoria, notice: 'Categoria was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @categoria.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categorias/1
  # DELETE /categorias/1.json
  def destroy
    @categoria = Categoria.find(params[:id])
    @categoria.destroy

    respond_to do |format|
      format.html { redirect_to categorias_url }
      format.json { head :no_content }
    end
  end

  def campos
    @campos = Categoria.find(params[:id]).campos.includes(:opciones)
    @campos.each do |c|
      c[:opciones] = c.opciones
    end
    respond_to do |format|
      format.json { render json: @campos }
    end
  end
private
  def limpiar_opciones
    if params[:categoria][:campos_attributes]
      params[:categoria][:campos_attributes].each do |k,v|
        if v[:tipo_campo] != 'opciones'
          params[:categoria][:campos_attributes][k].delete :opciones_attributes
        end
      end
    end
  end
  def administrar
    unless identificado? && usuario_actual.admin
      redirect_to root_path
    end
  end
end
