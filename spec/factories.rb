Factory.define :account do |a|
  a.sequence(:name) {|n| "account#{n}" }
  a.owner_id 1
  a.url 'http://www.tester.com'
  a.association :sport
end

Factory.define :stat_type do |s|
  s.sequence(:name) {|n| "stat#{n}" }  
  s.entity 'team'
end

Factory.define :sport do |s|
  s.name 'hockey'
end

Factory.define :league do |l|
  l.association :account
  l.name 'test league'
end

Factory.define :game do |g|
  g.league_id { League.find_by_name('test league') || Factory(:league).id}
  g.association :team1, :factory => :team
  g.association :team2, :factory => :team
end

Factory.define :team do |t|
  t.league_id { League.find_by_name('test league') || Factory(:league).id}
  t.sequence(:name) {|n| "team#{n}" }
  t.sequence(:team_tag) {|n| "t#{n}" }
end

Factory.define :league_stat do |s|
  s.association :league
  s.association :team
  s.association :stat_type
  s.value 1
end

Factory.define :user do |u|
  u.sequence(:username) {|n| "admin_#{n}"}
  u.sequence(:email) {|n| "user#{n}@test.com" }
  u.password "test123"
end

Factory.define :role do |r|
  r.name 'admin'
end

Factory.define :accounts_user do |a|
  a.association :account
  a.association :user
  a.association :role
  a.active 1
end
