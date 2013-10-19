require 'spec_helper'

describe Project do
  describe 'validations' do
    [:name, :description, :languages, :author].each do |attr|
      it { should validate_presence_of(attr) }
    end
  end

  describe '.search' do
    before do
      @cool = create(:project, :name => 'cool', :description => 'a cool project', :languages => 'ruby', :author => 'good fellow')
      @oldish = create(:project, :name => 'oldish camel', :description => 'just an regexp project', :languages => 'perl', :author => 'anonymous@example.com')
      @old_and_good = create(:project, :name =>'old and good', :description => 'only for real men', :languages => 'C', :author => 'hacker@example.com')
      @parallel = create(:project, :name => 'parallel', :description => 'we love concurrency and parallel things for good!', :languages => 'erlang', :author => 'master@example.com')
      @yahoo = create(:project, :name => 'Yahoo!')
      @yohoo = create(:project, :description => 'Yohoo!')
      @four = create(:project, :name => 'four')
      @far = create(:project, :name => 'far')
      @fur = create(:project, :description => 'fur')
      @five = create(:project, :name => 'five')
    end

    context 'when searching for old' do
      it 'finds two projects' do
        Project.search('old').count.should == 2
      end

      it 'finds the oldish project' do
        Project.search('old').should include(@oldish)
      end

      it 'finds the old_and_good project' do
        Project.search('old').should include(@old_and_good)
      end
    end

    context 'when searching for good' do
      it 'finds three projects' do
        Project.search('good').count.should == 3
      end

      it 'finds the cool project' do
        Project.search('good').should include(@cool)
      end

      it 'finds the old_and_good project' do
        Project.search('good').should include(@old_and_good)
      end

      it 'finds the parallel project' do
        Project.search('good').should include(@parallel)
      end
    end

    context 'when searching for Yahoo' do
      it 'finds two projects' do
        Project.search('Yahoo').count == 2
      end

      it 'finds Yahoo and Yohoo' do
        [@yahoo, @yohoo].each do |proj|
          Project.search('Yahoo').should include(proj)
        end
      end
    end

    context 'when searching for fir' do
      it 'finds three projects' do
        Project.search('fir').count == 3
      end

      it 'finds four, far, fur' do
       [@four, @far, @fur].each do |proj|
         Project.search('fir').should include(proj)
       end
      end
    end
  end
end
