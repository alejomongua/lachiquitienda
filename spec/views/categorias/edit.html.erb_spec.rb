require 'spec_helper'

describe "categorias/edit" do
  before(:each) do
    @categoria = assign(:categoria, stub_model(Categoria,
      :nombre => "MyString"
    ))
  end

  it "renders the edit categoria form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => categorias_path(@categoria), :method => "post" do
      assert_select "input#categoria_nombre", :name => "categoria[nombre]"
    end
  end
end
