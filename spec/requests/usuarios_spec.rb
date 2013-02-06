#encoding: utf-8

require 'spec_helper'

describe "Usuario" do
  before do
    @usuario_sin_permisos = Usuario.new(nombre: "pepito perez",
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
    it { should have_link("Regístrate") }
    it { should have_link("Identifícate") }
    describe 'desplegar el menu de inicio de sesion', js: true do
      before { click_link "Identifícate" }
      it { should have_button("Ingresar") }
      it { should have_link("¡Olvidé mi contraseña!") }
    end
    describe 'desplegar el menu de registro' do
      before { click_link "Regístrate" }
      it { should have_button("Regístrate") }
    end
  end

  describe "crear una cuenta", js: true do
    before { visit registrate_path }

    it { should have_content "Género" }

    describe 'registrarse' do
      before do
        fill_in "usuario_nombre", with: "Alejo Mongua"
        fill_in "usuario_email", with: "alejom.tv@gmail.com"
        fill_in "usuario_password", with: "foobar"
        fill_in "usuario_password_confirmation", with: "foobar"
        click_button "Regístrate"
      end
      it { should have_content('Alejo') }
      it { should_not have_link("Regístrate") }
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
          it { should_not have_button("Regístrate") }
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
        before { click_link "Alejo" }
        it { should have_link("Mi perfil") }

        describe 'informacion protegida' do
          before { click_link "Mi perfil" }
          it { should have_content("Opciones") } 
          it { should have_link("Opciones") } 
          describe 'editar' do
            before do
              click_link "Opciones"
              click_link "Editar"
            end

            it { should have_link('Cambiar avatar') }
            it { should have_link("Modificar contraseña") }
            describe 'modificar contraseña' do
              before { click_link "Modificar contraseña" }
              it { should have_selector("input[type='password']") }
            end
            describe 'modificar mi perfil' do
              before do
                fill_in "usuario_nick", with: "Alejin"
                click_button "Actualizar"
              end
              it { should have_content("Alejin") }
            end
          end
        end
      end
    end
  end

  describe "login", js: true do
    before do
      visit identificate_path
    end

    it { should have_link("¡Olvidé mi contraseña!") }

    pending { "probar manualmente el envio del correo y el reestablecimiento de la contraseña" }

    describe 'con permisos' do
      before do
        fill_in "sesion_email", with: @usuario_con_permisos.email
        fill_in "sesion_password", with: @usuario_con_permisos.password
        click_button "Ingresar"
        click_link "Usuario"
      end

      it { should have_link("Administrar") }      

      describe 'lista de usuarios' do
        before do
          click_link "Administrar" 
        end
        it { should have_content "Lista de usuarios" }
        it { should have_button "Buscar" }
        it { should have_content "Pepito" }
        describe 'buscar' do
          before do
            fill_in "buscar", with: "ejemplo"
            click_button "Buscar"
          end
          it { should_not have_content "Pepito" }
        end
      end
    end
  end

  describe 'login con facebook' do
    describe 'en el registro del home' do
      before { click_link "Regístrate" }
      it { should have_selector "a.conectar-con-facebook" }
    end

    describe 'en el formulario de ingreso' do
      before { visit identificate_path }
      it { should have_selector "a.conectar-con-facebook" }
    end

    describe 'en el login del home' do
      before { click_link "Identifícate" }
      it { should have_selector "a.conectar-con-facebook" }
    end

    describe 'en el formulario de registro' do
      before { visit registrate_path }
      it { should have_selector "a.conectar-con-facebook" }
    end
  end
end