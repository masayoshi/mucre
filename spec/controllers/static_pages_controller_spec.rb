require 'spec_helper'

describe StaticPagesController do

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
      response.should render_template("home")
    end
  end

  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
      response.should render_template("about")
    end
  end

  describe "GET 'policy'" do
    it "returns http success" do
      get 'policy'
      response.should be_success
      response.should render_template("policy")
    end
  end

  describe "GET 'help'" do
    it "returns http success" do
      get 'help'
      response.should be_success
      response.should render_template("help")
    end
  end

end
