#encoding: utf-8

require 'spec_helper'

describe Post do
  before do
  @usuario = Usuario.new(nombre: "usuario ejemplo",
                               email: "usuario@ejemplo.com",
                               password: "foobar",
                               password_confirmation: "foobar")
  @usuario.save!
  @post = Post.new(titulo: "Hola mundo",
                   contenido: "<p>Este es un post de prueba</p>",
                   autor: @usuario)
  end

  subject { @post}

  it { should be_valid }

  it { should respond_to :titulo }
  it { should respond_to :contenido }
  it { should respond_to :autor }
  it { should respond_to :publicado }
  it { should respond_to :comentarios }
  it { should respond_to :created_at }
  it { should respond_to :tags }
  it { should respond_to :tag_list }

  describe 'publicado' do
    before { @post.save }
    its(:publicado) { should == false }
  end
end