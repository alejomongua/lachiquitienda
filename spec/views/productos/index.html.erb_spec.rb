require 'spec_helper'

describe "productos/index" do
  before(:each) do
    assign(:productos, [
      stub_model(Producto,
        :nombre => "Nombre",
        :descripcion => "MyText",
        :categoria => nil,
        :precio => 1
      ),
      stub_model(Producto,
        :nombre => "Nombre",
        :descripcion => "MyText",
        :categoria => nil,
        :precio => 1
      )
    ])
  end

  it "renders a list of productos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
