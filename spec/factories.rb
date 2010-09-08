Factory.define :account do |a|
  a.sequence(:name) {|n| "account#{n}" }
  a.owner_id 1
  a.url 'http://www.tester.com'
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

Factory.define :user do |u|
  u.username "Admin"
  u.email "teeerevor@gmail.com"
  u.password "test123"
  #u.crypted_password "8a1a0739a0fb1a9549f551179cbe2459e5449111b51293050f72299a169ef474333c506496866f027cd9e206f2dcb0826b3303a1576ee3f5ded8b46a19e1397b"
  #u.password_salt "WfwI1WAKQ3RoYNG9uEiV"
  #u.persistence_token "32da3d598e2d807b5a77178f3e74269a8e580da59d0502a6d79664a6b30198b365befb3f91c051729086bc01729ca076acb01233e16587bafb015bf56cb526bd"
end

Factory.define :accounts_user do |a|
  a.association :account
  a.association :user
  a.role_id 1
  a.active 1
end
