require 'spec_helper'

describe Project do
  describe 'validations' do
    [:name, :description, :languages, :author].each do |attr|
      it { should validate_presence_of(attr) }
    end
  end

  describe '.search' do
    before do
      @cool = create(:project, :name => 'cool', :description => 'a cool project', :languages => 'ruby', :author => 'good fellow', :git_repo => 'antonioparisi/SourceLovers-Test')
      @oldish = create(:project, :name => 'oldish camel', :description => 'just an regexp project', :languages => 'perl', :author => 'anonymous@example.com', :git_repo => 'antonioparisi/SourceLovers-Test')
      @old_and_good = create(:project, :name =>'old and good', :description => 'only for real men', :languages => 'C', :author => 'hacker@example.com', :git_repo => 'antonioparisi/SourceLovers-Test')
      @parallel = create(:project, :name => 'parallel', :description => 'we love concurrency and parallel things for good!', :languages => 'erlang', :author => 'master@example.com', :git_repo => 'antonioparisi/SourceLovers-Test')
      @yahoo = create(:project, :name => 'Yahoo!', :git_repo => 'antonioparisi/SourceLovers-Test')
      @yohoo = create(:project, :description => 'Yohoo!', :git_repo => 'antonioparisi/SourceLovers-Test')
      @four = create(:project, :name => 'four', :git_repo => 'antonioparisi/SourceLovers-Test')
      @far = create(:project, :name => 'far', :git_repo => 'antonioparisi/SourceLovers-Test')
      @fur = create(:project, :description => 'fur', :git_repo => 'antonioparisi/SourceLovers-Test')
      @five = create(:project, :name => 'five', :git_repo => 'antonioparisi/SourceLovers-Test')
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
