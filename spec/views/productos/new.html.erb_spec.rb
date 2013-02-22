require 'spec_helper'

describe "productos/new" do
  before(:each) do
    assign(:producto, stub_model(Producto,
      :nombre => "MyString",
      :descripcion => "MyText",
      :categoria => nil,
      :precio => 1
    ).as_new_record)
  end

  it "renders new producto form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => productos_path, :method => "post" do
      assert_select "input#producto_nombre", :name => "producto[nombre]"
      assert_select "textarea#producto_descripcion", :name => "producto[descripcion]"
      assert_select "input#producto_categoria", :name => "producto[categoria]"
      assert_select "input#producto_precio", :name => "producto[precio]"
    end
  end
end
