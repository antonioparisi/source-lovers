require 'spec_helper'

describe GithubHooker do
  describe '#start' do
    before do
      @sample_manifest = <<-EOF
{
"ref":"refs/heads/master",
"after":"206ff4c360c890279bafc16d7e27f0400d12db82",
"before":"dfc1fc049645e9d4e05b8e926a55e98414408929",
"created":false,
"deleted":false,
"forced":false,
"compare":"https://github.com/antonioparisi/SourceLovers-Test/compare/dfc1fc049645...206ff4c360c8",
"commits":[
{
"id":"206ff4c360c890279bafc16d7e27f0400d12db82",
"distinct":true,
"message":"Add MANIFEST",
"timestamp":"2013-10-19T04:32:27-07:00",
"url":"https://github.com/antonioparisi/SourceLovers-Test/commit/206ff4c360c890279bafc16d7e27f0400d12db82",
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
"MANIFEST"
],
"removed":[

],
"modified":[

]
}
],
"head_commit":{
"id":"206ff4c360c890279bafc16d7e27f0400d12db82",
"distinct":true,
"message":"Add MANIFEST",
"timestamp":"2013-10-19T04:32:27-07:00",
"url":"https://github.com/antonioparisi/SourceLovers-Test/commit/206ff4c360c890279bafc16d7e27f0400d12db82",
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
"MANIFEST"
],
"removed":[

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
"pushed_at":1382182349,
"master_branch":"master"
},
"pusher":{
"name":"none"
}
}
      EOF
      @sample_manifest = JSON.parse(@sample_manifest)
    end

    it 'should create a sample project' do
      project_name    = @sample_manifest['repository']['name']
      repository_path = @sample_manifest['repository']['owner']['name'] + '/' + @sample_manifest['repository']['name']
      github_hooker = GithubHooker.new(project_name, repository_path)

      expect {
        github_hooker.start
      }.to change(Project, :count).by(1)
    end

    it 'should not create a sample project passing a nil repository_path' do
      project_name    = @sample_manifest['repository']['name']

      github_hooker = GithubHooker.new(project_name, nil)

      expect {
        github_hooker.start
      }.to change(Project, :count).by(0)
    end

  end
end
