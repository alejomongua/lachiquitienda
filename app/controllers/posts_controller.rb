#encoding: utf-8

class PostsController < ApplicationController
  before_filter :administrar_blog, except: [:index, :show]
  
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.order(:created_at, desc: true)
    if params[:etiquetas]
      @posts = @posts.tagged_with(params[:etiquetas]) 
      @etiqueta = params[:etiquetas]
    end
    if identificado? && usuario_actual.admin?
      @posts = @posts.paginate(page: params[:page])
    else
      @posts = @posts.where(publicado: true).paginate(page: params[:page])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    if @post.publicado || usuario_actual_admin?
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @post }
      end
    else
      redirect_to root_path 
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @post.autor = usuario_actual
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Se ha añadido una nueva entrada al blog' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Se ha actualizado el post' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
private
  def administrar_blog
    unless identificado? && usuario_actual.admin
      redirect_to root_path
    end
  end
end