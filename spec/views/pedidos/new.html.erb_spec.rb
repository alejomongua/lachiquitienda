require 'spec_helper'

describe "pedidos/new" do
  before(:each) do
    assign(:pedido, stub_model(Pedido,
      :guia => "MyString",
      :costo_envio => 1,
      :tipo_envio => "MyString",
      :direccion_envio => "MyString",
      :ciudad_envio => "MyString",
      :destinatario => "MyString",
      :tipo_pago => "MyString",
      :estado => "MyString",
      :usuario => nil
    ).as_new_record)
  end

  it "renders new pedido form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => pedidos_path, :method => "post" do
      assert_select "input#pedido_guia", :name => "pedido[guia]"
      assert_select "input#pedido_costo_envio", :name => "pedido[costo_envio]"
      assert_select "input#pedido_tipo_envio", :name => "pedido[tipo_envio]"
      assert_select "input#pedido_direccion_envio", :name => "pedido[direccion_envio]"
      assert_select "input#pedido_ciudad_envio", :name => "pedido[ciudad_envio]"
      assert_select "input#pedido_destinatario", :name => "pedido[destinatario]"
      assert_select "input#pedido_tipo_pago", :name => "pedido[tipo_pago]"
      assert_select "input#pedido_estado", :name => "pedido[estado]"
      assert_select "input#pedido_usuario", :name => "pedido[usuario]"
    end
  end
end
