FactoryGirl.define do
  factory :project do
    name 'foo'
    description 'bar'
    author 'potomak'
    languages 'ruby'
    data { {:foo => 'bar'} }
  end
end
