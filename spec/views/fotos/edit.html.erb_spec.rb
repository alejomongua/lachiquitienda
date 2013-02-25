require 'spec_helper'

describe "fotos/edit" do
  before(:each) do
    @foto = assign(:foto, stub_model(Foto,
      :nombre => "MyString",
      :producto => nil
    ))
  end

  it "renders the edit foto form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => fotos_path(@foto), :method => "post" do
      assert_select "input#foto_nombre", :name => "foto[nombre]"
      assert_select "input#foto_producto", :name => "foto[producto]"
    end
  end
end
