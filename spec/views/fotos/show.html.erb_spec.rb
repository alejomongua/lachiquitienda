require 'spec_helper'

describe "fotos/show" do
  before(:each) do
    @foto = assign(:foto, stub_model(Foto,
      :nombre => "Nombre",
      :producto => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nombre/)
    rendered.should match(//)
  end
end
