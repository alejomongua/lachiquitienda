require 'spec_helper'

describe "pedidos/show" do
  before(:each) do
    @pedido = assign(:pedido, stub_model(Pedido,
      :guia => "Guia",
      :costo_envio => 1,
      :tipo_envio => "Tipo Envio",
      :direccion_envio => "Direccion Envio",
      :ciudad_envio => "Ciudad Envio",
      :destinatario => "Destinatario",
      :tipo_pago => "Tipo Pago",
      :estado => "Estado",
      :usuario => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Guia/)
    rendered.should match(/1/)
    rendered.should match(/Tipo Envio/)
    rendered.should match(/Direccion Envio/)
    rendered.should match(/Ciudad Envio/)
    rendered.should match(/Destinatario/)
    rendered.should match(/Tipo Pago/)
    rendered.should match(/Estado/)
    rendered.should match(//)
  end
end
