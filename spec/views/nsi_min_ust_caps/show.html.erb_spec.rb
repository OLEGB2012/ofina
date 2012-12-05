require 'spec_helper'

describe "nsi_min_ust_caps/show" do
  before(:each) do
    @nsi_min_ust_cap = assign(:nsi_min_ust_cap, stub_model(NsiMinUstCap,
      :enterprise_id => 1,
      :summa => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
