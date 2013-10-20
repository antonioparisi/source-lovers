require 'spec_helper'

describe HooksController do
  describe 'POST /hooks/github' do
    before(:each) do
      @sample_manifest = <<-EOF
{
"ref":"refs/heads/master",
"after":"a3b7b927a8483a1ae996553fe17fdb490a270f15",
"before":"206ff4c360c890279bafc16d7e27f0400d12db82",
"created":false,
"deleted":false,
"forced":false,
"compare":"https://github.com/antonioparisi/SourceLovers-Test/compare/206ff4c360c8...a3b7b927a848",
"commits":[
{
"id":"a3b7b927a8483a1ae996553fe17fdb490a270f15",
"distinct":true,
"message":"rename MANIFEST to sourcelover.json",
"timestamp":"2013-10-20T01:26:38-07:00",
"url":"https://github.com/antonioparisi/SourceLovers-Test/commit/a3b7b927a8483a1ae996553fe17fdb490a270f15",
"author":{
"name":"Antonio Parisi",
"email":"ant.parisi@gmail.com",
"username":"antonioparisi"
},
"committer":{
"name":"Antonio Parisi",
"email":"ant.parisi@gmail.com",
"username":"antonioparisi"
},
"added":[
".gitignore",
"sourcelover.json"
],
"removed":[
"MANIFEST"
],
"modified":[

]
}
],
"head_commit":{
"id":"a3b7b927a8483a1ae996553fe17fdb490a270f15",
"distinct":true,
"message":"rename MANIFEST to sourcelover.json",
"timestamp":"2013-10-20T01:26:38-07:00",
"url":"https://github.com/antonioparisi/SourceLovers-Test/commit/a3b7b927a8483a1ae996553fe17fdb490a270f15",
"author":{
"name":"Antonio Parisi",
"email":"ant.parisi@gmail.com",
"username":"antonioparisi"
},
"committer":{
"name":"Antonio Parisi",
"email":"ant.parisi@gmail.com",
"username":"antonioparisi"
},
"added":[
".gitignore",
"sourcelover.json"
],
"removed":[
"MANIFEST"
],
"modified":[

]
},
"repository":{
"id":13698838,
"name":"SourceLovers-Test",
"url":"https://github.com/antonioparisi/SourceLovers-Test",
"description":"SourceLovers-Test",
"watchers":0,
"stargazers":0,
"forks":0,
"fork":false,
"size":116,
"owner":{
"name":"antonioparisi",
"email":"ant.parisi@gmail.com"
},
"private":false,
"open_issues":0,
"has_issues":true,
"has_downloads":true,
"has_wiki":true,
"created_at":1382175791,
"pushed_at":1382257602,
"master_branch":"master"
},
"pusher":{
"name":"antonioparisi",
"email":"ant.parisi@gmail.com"
}
}
      EOF
    end

    it "should create a Project" do
      @json_manifest = JSON.parse(@sample_manifest)

      project_name = @json_manifest['repository']['name']
      repository_path = @json_manifest['repository']['owner']['name'] + '/' + @json_manifest['repository']['name']
      ProjectUpdater.should_receive(:perform_async).with(project_name, repository_path)

      post :github, payload: @sample_manifest
    end
  end

end
