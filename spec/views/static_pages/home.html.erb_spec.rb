require 'spec_helper'

describe "static_pages/home.html.erb" do

  before { render }

  it "should have correct headline" do
    rendered.should have_selector 'h1', text: "MuseumCreated.com"
  end
end
