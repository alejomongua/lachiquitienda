require 'spec_helper'

describe "items/new" do
  before(:each) do
    assign(:item, stub_model(Item,
      :usuario => nil,
      :producto => nil,
      :pedido => nil,
      :cantidad => 1,
      :precio => 1
    ).as_new_record)
  end

  it "renders new item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => items_path, :method => "post" do
      assert_select "input#item_usuario", :name => "item[usuario]"
      assert_select "input#item_producto", :name => "item[producto]"
      assert_select "input#item_pedido", :name => "item[pedido]"
      assert_select "input#item_cantidad", :name => "item[cantidad]"
      assert_select "input#item_precio", :name => "item[precio]"
    end
  end
end
