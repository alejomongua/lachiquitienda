#encoding: utf-8

require 'spec_helper'

describe Usuario do
  before { @usuario = Usuario.new(nombre: "usuario ejemplo",
                               email: "usuario@ejemplo.com",
                               password: "foobar",
                               password_confirmation: "foobar") }
  subject { @usuario }

  it { should be_valid }

  it { should respond_to(:nombre) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }  
  it { should respond_to(:remember_token) }
  it { should respond_to(:admin) }
  it { should respond_to(:admin?) }

  describe "nombre" do
    describe "en blanco" do
      before { @usuario.nombre = " " }
      it { should_not be_valid }      
    end
    describe "muy largo" do
      before { @usuario.nombre = 'a'*51 }
      it { should_not be_valid }      
    end
    describe "muy corto" do
      before { @usuario.nombre = 'aaa' }
      it { should_not be_valid }
    end
  end

  describe "email" do
    it "formato incorrecto" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @usuario.email = invalid_address
        @usuario.should_not be_valid
      end      
    end
    it "formato correcto" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn alejom_tv@hotmail.com]
      addresses.each do |valid_address|
        @usuario.nombre = valid_address
        @usuario.should be_valid
      end      
    end
    describe "tomado" do
      before do
        user_with_same_email = @usuario.dup
        user_with_same_email.save
      end
      it { should_not be_valid }
    end    
  end

  describe "password" do
    describe "no está presente" do
      before { @usuario.password = @usuario.password_confirmation = " " }
      it { should_not be_valid }      
    end
    describe "no concuerda la confirmación" do
      before { @usuario.password_confirmation = "mismatch" }
      it { should_not be_valid }
    end
    describe "confirmacion es 'nil'" do
      before { @usuario.password_confirmation = nil }
      it { should_not be_valid }
    end
    describe "muy corto" do
      before { @usuario.password = @usuario.password_confirmation = "a" * 5 }
      it { should be_invalid }  
    end
  end

  describe "administrador" do
    before { @usuario.admin = true }
    it { should be_valid }
    its(:admin?) { should == true }
  end

  describe "almacenado " do
    before { @usuario.save }

    its(:admin) { should == false }

    describe "retorno del metodo de autenticacion" do
      let(:found_user) { Usuario.find_by_email(@usuario.email) }

      describe "con password valido" do
        it { should == found_user.authenticate(@usuario.password) }
      end

      describe "con password invalido" do
        let(:user_for_invalid_password) { found_user.authenticate("invalid") }

        it { should_not == user_for_invalid_password }
        specify { user_for_invalid_password.should be_false }
      end
    end

    describe "remember token" do
      its(:remember_token) { should_not be_blank }
    end

    describe "capitalizacion" do
      its(:nombre) { should  == "Usuario Ejemplo"}
    end      
  end
end