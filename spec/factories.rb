Factory.define :account do |a|
  a.sequence(:name) {|n| "account#{n}" }
  a.owner_id 1
  a.url 'test@test.com'
  a.association :sport
end

Factory.define :stat_type do |s|
  s.name 'stat'  
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

#more often then not league team and stat_type 
#will already be created
Factory.define :league_stat do |s|
  s.association :league
  s.association :team
  s.association :stat_type
  s.value 1
end