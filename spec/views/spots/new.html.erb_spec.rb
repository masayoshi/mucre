require 'spec_helper'

describe "spots/new" do
  before(:each) do
    assign(:spot, stub_model(Spot,
      :name => "MyString",
      :address => "MyString",
      :latitude => 1.5,
      :longitude => 1.5
    ).as_new_record)
  end

  it "renders new spot form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => spots_path, :method => "post" do
      assert_select "input#spot_name", :name => "spot[name]"
      assert_select "input#spot_address", :name => "spot[address]"
      assert_select "input#spot_latitude", :name => "spot[latitude]"
      assert_select "input#spot_longitude", :name => "spot[longitude]"
    end
  end
end
