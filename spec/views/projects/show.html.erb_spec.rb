require 'spec_helper'

describe "projects/show" do
  before(:each) do
    @project = assign(:project, stub_model(Project, attributes_for(:project)))
  end

  it "renders attributes in <p>" do
    render

    rendered.should match(@project.name)
    rendered.should match(@project.description)
  end
end
