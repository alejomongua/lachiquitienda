require "spec_helper"

describe PedidosController do
  describe "routing" do

    it "routes to #index" do
      get("/pedidos").should route_to("pedidos#index")
    end

    it "routes to #new" do
      get("/pedidos/new").should route_to("pedidos#new")
    end

    it "routes to #show" do
      get("/pedidos/1").should route_to("pedidos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/pedidos/1/edit").should route_to("pedidos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/pedidos").should route_to("pedidos#create")
    end

    it "routes to #update" do
      put("/pedidos/1").should route_to("pedidos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/pedidos/1").should route_to("pedidos#destroy", :id => "1")
    end

  end
end
