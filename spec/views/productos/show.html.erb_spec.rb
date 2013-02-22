require 'spec_helper'

describe "productos/show" do
  before(:each) do
    @producto = assign(:producto, stub_model(Producto,
      :nombre => "Nombre",
      :descripcion => "MyText",
      :categoria => nil,
      :precio => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nombre/)
    rendered.should match(/MyText/)
    rendered.should match(//)
    rendered.should match(/1/)
  end
end
