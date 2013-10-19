require 'spec_helper'

describe ProjectsController do
  let(:valid_attributes) {
    {
      'name' => 'Redis',
      'description' => 'Redis is an open source, BSD licensed, advanced key-value store',
      'languages' => 'C',
      'author' => 'Salvatore antirez Sanfilippo'
    }
  }

  describe 'GET index' do
    it 'assigns all projects as @projects' do
      project = Project.create! valid_attributes
      get :index, {}
      assigns(:projects).should eq([project])
    end

    it 'is ok' do
      get :index
      response.status.should == 200
    end

    context 'with q param' do
      before do
        @redis = create(:project, valid_attributes)
        @sidekiq = create(:project, :name => 'Sidekiq', :description => 'Simple, efficient background processing for Ruby',
          :languages => 'Ruby', :author => 'Mike mperham Perham')
        @redis_rb = create(:project, :name => 'redis-rb', :description => 'A Ruby client library for Redis',
          :languages => 'Ruby', :author => 'Ezra Zygmuntowicz, Taylor Weibley, Matthew Clark, Luca Guidi')
      end

      it 'searches for projects' do
        get :index, {:q => 'redis'}
        assigns(:projects).should include(@redis)
        assigns(:projects).should include(@redis_rb)
      end
    end
  end

  describe 'GET show' do
    it 'assigns the requested project as @project' do
      project = Project.create! valid_attributes
      get :show, {:id => project.to_param}
      assigns(:project).should eq(project)
    end
  end

end
