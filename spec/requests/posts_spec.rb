#encoding: utf-8

require 'spec_helper'

describe "Posts" do
  before do
    @usuario_sin_permisos = Usuario.new(nombre: "pepito perez",
                        email: "usuario@example.com",
                        password: "foobar",
                        password_confirmation: "foobar")
    @usuario_sin_permisos.save!
    @usuario_con_permisos = Usuario.new(nombre: "usuario ejemplo con permisos",
                        email: "usuario_con_permisos@example.com",
                        password: "foobar",
                        password_confirmation: "foobar",
                        admin: true)
    @usuario_con_permisos.save!
    @post = Post.new( titulo: "Hola mundo",
                      contenido: "<p>Este es un post de prueba</p>",
                      autor: @usuario_con_permisos,
                      tag_list: 'Prueba',
                      publicado: true)
    @post.save!
    @post_no_publicado = Post.new( titulo: "lorem ipsum",
                      contenido: "<p>si la vida fuera estable todo el tiempo yo no beberia ni malgastaria la plata</p>
                                  <!-- leer_mas -->
                                  <div>Pero me doy cuenta que la vida es un sueño y antes de morir es mejor aprovecharla</div>",
                      autor: @usuario_con_permisos)
  end

  subject { page }

  describe 'sin identificar' do
    before { visit new_post_path }
    it { should have_selector("body.paginas_estaticas_inicio") } #redirige a root_path

    describe 'post' do
      before { visit posts_path }
      it { should have_content('Hola mundo') }
      it { should_not have_link "Editar" }
      it { should_not have_link "Eliminar" }
      it { should_not have_link "Leer más" }
      it { should_not have_content('div') }
      it { should_not have_content('Pero me doy cuenta') }
      describe 'no publicado' do
        before { @post_no_publicado.save! }
        it { should_not have_content @post_no_publicado.titulo }
        describe 'protegido' do
          before { visit post_path(@post_no_publicado.id) }
          it { should have_selector("body.paginas_estaticas_inicio") } #redirige a root_path
        end
      end
    end
  end

  describe 'sin permisos' do
    before do 
      visit identificate_path
      fill_in "sesion_email", with: @usuario_sin_permisos.email
      fill_in "sesion_password", with: @usuario_sin_permisos.password
      click_button "Ingresar"
      visit new_post_path
    end
    it { should have_selector("body.paginas_estaticas_inicio") } #redirige a root_path

    describe 'post' do
      before { visit posts_path }
      it { should have_content('Hola mundo') }
      it { should_not have_link "Editar" }
      it { should_not have_link "Eliminar" }
      it { should_not have_link "Leer más" }
      it { should_not have_content('div') }
      it { should_not have_content('Pero me doy cuenta') }
      describe 'no publicado' do
        before { @post_no_publicado.save! }
        it { should_not have_content @post_no_publicado.titulo }
        describe 'protegido' do
          before { visit post_path(@post_no_publicado) }
          it { should have_selector("body.paginas_estaticas_inicio") } #redirige a root_path
        end
      end
    end
  end

  describe 'con permisos' do
    before do
      @post_no_publicado.save!
      visit identificate_path
      fill_in "sesion_email", with: @usuario_con_permisos.email
      fill_in "sesion_password", with: @usuario_con_permisos.password
      click_button "Ingresar"
    end
    describe 'post' do
      before { visit posts_path }
      it { should have_content('Hola mundo') }
      it { should have_link "Editar" }
      it { should have_link "Eliminar" }
      it { should have_link "Leer más" }
      it { should_not have_content('div') }
      it { should_not have_content('Pero me doy cuenta') }
      describe 'visitar la página del post' do
        before { click_link "Leer más" }
        it { should have_content "Pero me doy cuenta" }
      end
      describe 'no publicado' do
        it { should have_content @post_no_publicado.titulo }
        describe 'protegido' do
          before { visit post_path(@post_no_publicado) }
          it { should_not have_selector("body.paginas_estaticas_inicio") } #redirige a root_path
        end
      end
    end

    describe 'formulario de nuevo post' do
      before { visit new_post_path }

      it { should have_content "Etiquetas" }

      describe 'crear post' do
        before do
          fill_in "post_titulo", with: "Yet another post"
          fill_in "post_contenido", with: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut sed felis a augue molestie accumsan quis vitae nisl. Maecenas eu ultrices nibh. Cras quis egestas ligula. Phasellus vulputate dui at augue consectetur tempor. Aenean quis neque sed augue malesuada faucibus. Sed pharetra, arcu in viverra laoreet, nulla elit pulvinar massa, non vestibulum libero dolor ac dolor. Maecenas lectus leo, venenatis vitae auctor non, interdum at libero. Nunc lacinia massa adipiscing eros suscipit non tincidunt massa blandit."
          click_button "Guardar post"
        end

        it { should have_content "Yet another post" }
        it { should have_link "Editar" }
        it { should have_link "Eliminar" }

        describe 'Editar' do
          before { visit edit_post_path(@post) }

          it { should have_selector 'body.posts_edit' }

          describe 'agregar Etiquetas' do
            before do
              fill_in 'post_tag_list', with: "Prueba, Estimulacion"
              click_button "Guardar post"
            end

            it { should have_content 'Etiquetado en:'}
            it { should have_link 'Prueba' }

            describe 'filtro por etiquetas' do
              before { click_link 'Prueba' }
              
              it { should have_content 'Mostrando solo los etiquetados en Prueba'}
              it { should have_link 'Mostrar todos'}
   #           it { should have_content 'Yet another post' }
              it { should have_content 'Hola mundo' }
              it { should_not have_content 'si la vida' }
              # describe 'meta tags' do
              #   before { click_link @post.titulo }
              #   it { should have_css "meta[name='description'][content='#{ActionView::Helpers::SanitizeHelper.strip_tags @post.contenido.split('<!-- leer_mas -->').first}']" }
              #   it { should have_css "meta[name='keywords'][content='#{@post.tag_list}']" }
              # end
            end
          end
        end
      end
    end
  end
end