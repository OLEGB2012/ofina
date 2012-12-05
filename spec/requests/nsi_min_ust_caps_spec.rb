require 'spec_helper'

describe "NsiMinUstCaps" do
  describe "GET /nsi_min_ust_caps" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get nsi_min_ust_caps_path
      response.status.should be(200)
    end
  end
end
