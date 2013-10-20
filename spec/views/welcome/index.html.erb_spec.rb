require 'spec_helper'

describe "welcome/index.html.erb" do
  it "renders a welcome page" do
    render

    assert_select "h1", :text => "We are Source Lovers"
  end
end
