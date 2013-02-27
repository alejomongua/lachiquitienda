#encoding: utf-8

require 'spec_helper'

describe Categoria do

  let(:categoria) { FactoryGirl.create(:categoria) }
  let(:otra_categoria) { FactoryGirl.build(:categoria, nombre: categoria.nombre)}

  subject { categoria }

  it { should be_valid }

  it { should respond_to :nombre }
  it { should respond_to :campos }

  describe "nombre" do
    describe "en blanco" do
      before { categoria.nombre = " " }
      it { should_not be_valid }      
    end
    describe "repetido" do
      it { otra_categoria.should_not be_valid }      
    end
  end

  describe "agregar campos" do
    before { @campo = categoria.campos.build(nombre: "campo1", tipo_campo: "check_box") }

    it { @campo.should be_valid }
    it { @campo.should respond_to :nombre }
    it { @campo.should respond_to :tipo_campo }
    it { @campo.should respond_to :requerido }
      
    describe "valores válidos" do
      valores = %w[texto texto_extenso numero decimal check_box]
      valores.each do |valido|
        it "debe permitir #{valido}" do
          @campo.tipo_campo = valido
          @campo.should be_valid  
        end
      end    
    end

    describe "valores inválidos" do
      valores = %w[textos seleccion select multiple cadena]
      valores.each do |invalido|
        it "no debe permitir #{invalido}" do
          @campo.tipo_campo = invalido
          @campo.should_not be_valid
        end
      end    
    end
  end
end
