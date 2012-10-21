require 'spec_helper'

describe "static_pages/about.html.erb" do

  before { render }

  it "should have correct headline" do
    rendered.should have_selector 'h1', text: "About"
  end
end
