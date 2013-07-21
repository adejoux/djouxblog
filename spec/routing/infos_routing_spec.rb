require "spec_helper"

describe InfosController do
  describe "routing" do

    it "routes to #index" do
      get("/infos").should route_to("infos#index")
    end

    it "routes to #new" do
      get("/infos/new").should route_to("infos#new")
    end

    it "routes to #show" do
      get("/infos/1").should route_to("infos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/infos/1/edit").should route_to("infos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/infos").should route_to("infos#create")
    end

    it "routes to #update" do
      put("/infos/1").should route_to("infos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/infos/1").should route_to("infos#destroy", :id => "1")
    end

  end
end
