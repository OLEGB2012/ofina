require 'spec_helper'

describe "nsi_min_ust_caps/new" do
  before(:each) do
    assign(:nsi_min_ust_cap, stub_model(NsiMinUstCap,
      :enterprise_id => 1,
      :summa => 1
    ).as_new_record)
  end

  it "renders new nsi_min_ust_cap form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => nsi_min_ust_caps_path, :method => "post" do
      assert_select "input#nsi_min_ust_cap_enterprise_id", :name => "nsi_min_ust_cap[enterprise_id]"
      assert_select "input#nsi_min_ust_cap_summa", :name => "nsi_min_ust_cap[summa]"
    end
  end
end
