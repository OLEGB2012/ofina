require 'spec_helper'

describe "nsi_min_ust_caps/edit" do
  before(:each) do
    @nsi_min_ust_cap = assign(:nsi_min_ust_cap, stub_model(NsiMinUstCap,
      :enterprise_id => 1,
      :summa => 1
    ))
  end

  it "renders the edit nsi_min_ust_cap form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => nsi_min_ust_caps_path(@nsi_min_ust_cap), :method => "post" do
      assert_select "input#nsi_min_ust_cap_enterprise_id", :name => "nsi_min_ust_cap[enterprise_id]"
      assert_select "input#nsi_min_ust_cap_summa", :name => "nsi_min_ust_cap[summa]"
    end
  end
end
