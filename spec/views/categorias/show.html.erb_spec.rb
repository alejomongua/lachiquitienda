require 'spec_helper'

describe "categorias/show" do
  before(:each) do
    @categoria = assign(:categoria, stub_model(Categoria,
      :nombre => "Nombre"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nombre/)
  end
end
