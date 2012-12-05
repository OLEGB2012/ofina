require 'spec_helper'

describe "nsi_min_ust_caps/index" do
  before(:each) do
    assign(:nsi_min_ust_caps, [
      stub_model(NsiMinUstCap,
        :enterprise_id => 1,
        :summa => 2
      ),
      stub_model(NsiMinUstCap,
        :enterprise_id => 1,
        :summa => 2
      )
    ])
  end

  it "renders a list of nsi_min_ust_caps" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
