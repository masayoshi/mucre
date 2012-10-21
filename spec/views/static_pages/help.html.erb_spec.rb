require 'spec_helper'

describe "static_pages/help.html.erb" do

  before { render }

  it "should have correct headline" do
    rendered.should have_selector 'h1', text: "Help"
  end
end
