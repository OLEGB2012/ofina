require "spec_helper"

describe NsiMinUstCapsController do
  describe "routing" do

    it "routes to #index" do
      get("/nsi_min_ust_caps").should route_to("nsi_min_ust_caps#index")
    end

    it "routes to #new" do
      get("/nsi_min_ust_caps/new").should route_to("nsi_min_ust_caps#new")
    end

    it "routes to #show" do
      get("/nsi_min_ust_caps/1").should route_to("nsi_min_ust_caps#show", :id => "1")
    end

    it "routes to #edit" do
      get("/nsi_min_ust_caps/1/edit").should route_to("nsi_min_ust_caps#edit", :id => "1")
    end

    it "routes to #create" do
      post("/nsi_min_ust_caps").should route_to("nsi_min_ust_caps#create")
    end

    it "routes to #update" do
      put("/nsi_min_ust_caps/1").should route_to("nsi_min_ust_caps#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/nsi_min_ust_caps/1").should route_to("nsi_min_ust_caps#destroy", :id => "1")
    end

  end
end
