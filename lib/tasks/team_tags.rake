namespace :data do
  desc 'load team tag field by grabbing the first three letter of the team name'
  task :team_tags => :environment do
    puts "Creating team_tags data for teams..."
    Team.all.each do |team|
      arr = team.name.split
      arr.each do |name|
        team.team_tag = name[0..2] if !(name =~ /\bthe\b/i)
      end
      team.save
    end
  end
end