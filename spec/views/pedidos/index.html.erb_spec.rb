require 'spec_helper'

describe "pedidos/index" do
  before(:each) do
    assign(:pedidos, [
      stub_model(Pedido,
        :guia => "Guia",
        :costo_envio => 1,
        :tipo_envio => "Tipo Envio",
        :direccion_envio => "Direccion Envio",
        :ciudad_envio => "Ciudad Envio",
        :destinatario => "Destinatario",
        :tipo_pago => "Tipo Pago",
        :estado => "Estado",
        :usuario => nil
      ),
      stub_model(Pedido,
        :guia => "Guia",
        :costo_envio => 1,
        :tipo_envio => "Tipo Envio",
        :direccion_envio => "Direccion Envio",
        :ciudad_envio => "Ciudad Envio",
        :destinatario => "Destinatario",
        :tipo_pago => "Tipo Pago",
        :estado => "Estado",
        :usuario => nil
      )
    ])
  end

  it "renders a list of pedidos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Guia".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Tipo Envio".to_s, :count => 2
    assert_select "tr>td", :text => "Direccion Envio".to_s, :count => 2
    assert_select "tr>td", :text => "Ciudad Envio".to_s, :count => 2
    assert_select "tr>td", :text => "Destinatario".to_s, :count => 2
    assert_select "tr>td", :text => "Tipo Pago".to_s, :count => 2
    assert_select "tr>td", :text => "Estado".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
