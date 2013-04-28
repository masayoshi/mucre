require 'spec_helper'

describe "spots/show" do
  before(:each) do
    @spot = assign(:spot, stub_model(Spot,
      :name => "Name",
      :address => "Address",
      :latitude => 1.5,
      :longitude => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Address/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
  end
end
