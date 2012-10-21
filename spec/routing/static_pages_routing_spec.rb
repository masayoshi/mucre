require "spec_helper"

describe "routing to StaticPages" do
  it "routes / to static_pages#home" do
    expect(get: root_path).to route_to(controller: "static_pages", action: "home")
  end

  it "routes /about to static_pages#about" do
    expect(get: about_path).to route_to(controller: "static_pages", action: "about")
  end

  it "routes /help to static_pages#help" do
    expect(get: help_path).to route_to(controller: "static_pages", action: "help")
  end

  it "routes /policy to static_pages#policy" do
    expect(get: policy_path).to route_to(controller: "static_pages", action: "policy")
  end
end
