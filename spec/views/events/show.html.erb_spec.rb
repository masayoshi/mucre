require 'spec_helper'

describe "events/show" do
  before(:each) do
    @event = assign(:event, stub_model(Event,
      :title => "Title",
      :place => "Place",
      :address => "Address",
      :latitude => 1.5,
      :longitude => 1.5,
      :description => "MyText",
      :url => "Url",
      :fee => 1,
      :user_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Place/)
    rendered.should match(/Address/)
    rendered.should match(/1.5/)
    rendered.should match(/1.5/)
    rendered.should match(/MyText/)
    rendered.should match(/Url/)
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
