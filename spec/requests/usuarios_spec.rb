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
    it { should_not have_content('Cerrar sesión') }
    it { should_not have_content('Mi perfil') }
    it { should have_link("Registrese", href: registrate_path) }
    it { should have_link("Identifícate", href: identificate_path) }
  end

  describe "crear una cuenta" do
    before do
      visit registrate_path
      fill_in "usuario_nombre", with: "Alejandro Mongua"
      fill_in "usuario_nick", with: "Alejo"
      fill_in "usuario_email", with: "alejom.tv@gmail.com"
      fill_in "password", with: "foobar"
      fill_in "password_confirmation", with: "foobar"
      click_button "Registrarme"
    end
    it { should have_content('Hola Alejo') }
    it { should have_link('Cerrar sesión', href: salir_path) }
    it { should have_link('Mi perfil') }
    it { should_not have_link("Registrate") }
    it { should_not have_link("Identifícate") }
    it { should_not have_link('Administrar')}

    describe "cuando ya está identificado" do
      before { visit registrate_path }
      it { should_not have_button("Registrarme") }
      it { should have_selector("body.paginas_estaticas_inicio") } #redirige a root_path
    end

    describe "visitar nuevamente el login" do
      before { visit identificate_path }
      it { should_not have_button("Ingresar") }
      it { should have_selector("body.paginas_estaticas_inicio") } #redirige a root_path
    end

    describe "informacion protegida" do
      before { visit usuario_path(@usuario_con_permisos) }
      it { should have_selector("body.paginas_estaticas_inicio") } #redirige a root_path
    end

    describe 'mi propio perfil' do
      describe 'informacion protegida' do
        before { click_link "Mi perfil" }

        it { should have_link('Editar') }
        
        describe 'editar' do
          before { click_link "Editar" }

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
