#encoding: utf-8

require 'spec_helper'

describe "Usuario" do
  before do
    @usuario_sin_permisos = Usuario.new(nombre: "usuario ejemplo",
                        email: "usuario@example.com",
                        password: "foobar",
                        password_confirmation: "foobar")
    @usuario_sin_permisos.save
    @usuario_con_permisos = Usuario.new(nombre: "usuario ejemplo con permisos",
                        email: "usuario_con_permisos@example.com",
                        password: "foobar",
                        password_confirmation: "foobar",
                        admin: true)
    @usuario_con_permisos.save
    visit root_path
  end  

  subject { page }

  describe "sin identificar" do
    it { should_not have_content('Salir') }
    it { should_not have_content('Mi perfil') }
    it { should have_link("Registrate") }
    it { should have_link("Identifícate") }
  end

  describe "crear una cuenta", js: true do
    before do
      visit registrate_path
      fill_in "usuario_nombre", with: "Alejo Mongua"
      #fill_in "usuario_nick", with: "Alejo"
      fill_in "usuario_email", with: "alejom.tv@gmail.com"
      fill_in "usuario_password", with: "foobar"
      fill_in "usuario_password_confirmation", with: "foobar"
      click_button "Registrarme"
    end
    it { should have_content('Alejo') }
    it { should_not have_link("Registrate") }
    it { should_not have_link("Identifícate") }
    it { should_not have_link('Administrar')}

    describe "cuando ya está identificado" do
      describe "ver mis links" do
        before { click_link "Alejo" }
        it { should have_link('Salir', href: salir_path) }
        it { should have_link('Mi perfil') }
      end
    
      describe "intentar registrarme nuevamente" do
        before { visit registrate_path }
        it { should_not have_button("Registrarme") }
        it { should have_selector("body.paginas_estaticas_inicio") } #redirige a root_path        
      end
    end

    describe "visitar nuevamente el login" do
      before { visit identificate_path }
      it { should_not have_button("Ingresar") }
      it { should have_selector("body.paginas_estaticas_inicio") } #redirige a root_path
      it { should have_content("Bienvenido") } #redirige a root_path
    end

    describe "informacion protegida" do
      before { visit usuario_path(@usuario_con_permisos) }
      it { should have_selector("body.paginas_estaticas_inicio") } #redirige a root_path
    end

    describe 'mi propio perfil' do
      before { click_link "Alejo Mongua" }
      describe 'informacion protegida' do
        before { click_link "Mi perfil" }
       
        describe 'editar' do
          before do
            click_link "Opciones"
            click_link "Editar"
          end

          it { should have_link('Cambiar avatar') }
          it { should have_link("Modificar contraseña") }
        end
      end
    end
  end

  describe "con permisos" do
    before do
      visit root_path
      fill_in "sesion_email", with: @usuario_con_permisos.email
      fill_in "sesion_password", with: @usuario_con_permisos.password
      click_button "Ingresar"
    end
    
    it { should_not have_link('Administrar')}
  end
end