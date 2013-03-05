#encoding: utf-8

require 'spec_helper'

describe Producto do
  let(:producto) { FactoryGirl.build(:producto) }
  let(:otro_producto) { FactoryGirl.build(:producto) }

  subject { producto }

  it { should respond_to :nombre }
  it { should respond_to :categoria }
  it { should respond_to :descripcion }
  it { should respond_to :precio }
  it { should respond_to :cantidad }
  it { should respond_to :fotos }
  it { should respond_to :propiedades }
  it { should respond_to :comentarios }
  it { should respond_to :descuento }

  it { should be_valid }

  describe "nombre" do
    describe "en blanco" do
      before { nombre = " " }
      it { should_not be_valid }      
    end
    describe "repetido" do
      it { otro_producto.should_not be_valid }      
    end
  end

  describe "agregar campos" do
    before do
      producto.categoria.campos.create!(nombre: "campo1", tipo_campo: "check_box")
      producto.propiedades = { campo1: "valor" }
    end

    it { should be_valid }
  end

end