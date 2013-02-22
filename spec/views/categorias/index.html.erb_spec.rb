require 'spec_helper'

describe "categorias/index" do
  before(:each) do
    assign(:categorias, [
      stub_model(Categoria,
        :nombre => "Nombre"
      ),
      stub_model(Categoria,
        :nombre => "Nombre"
      )
    ])
  end

  it "renders a list of categorias" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
  end
end
