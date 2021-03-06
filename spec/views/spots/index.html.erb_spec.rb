require 'spec_helper'

describe "spots/index" do
  before(:each) do
    assign(:spots, [
      stub_model(Spot,
        :name => "Name",
        :address => "Address",
        :latitude => 1.5,
        :longitude => 1.5
      ),
      stub_model(Spot,
        :name => "Name",
        :address => "Address",
        :latitude => 1.5,
        :longitude => 1.5
      )
    ])
  end

  it "renders a list of spots" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
