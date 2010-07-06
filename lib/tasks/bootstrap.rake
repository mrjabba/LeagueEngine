namespace :site do
  desc 'load an data needed as a base in the dev db'
  task :bootstrap => :environment do
    puts "Creating base data..."
    
    unless Sport.find_by_name('soccer')
      Sport.create(:name => "Soccer")
      Sport.create(:name => "Netball")
      Sport.create(:name => "Rubgy League")
      Sport.create(:name => "Water Polo")       
    end
    
    unless StatType.find_by_name('gameplayed')
      StatType.create(:name => 'GamePlayed', :entity => 'player')
      StatType.create(:name => 'Goals', :entity => 'team')
      StatType.create(:name => 'Goal', :entity => 'player')
      StatType.create(:name => 'Goals', :entity => 'player')
      StatType.create(:name => 'Exclusion', :entity => 'player')
      StatType.create(:name => 'Exclusions', :entity => 'player')       
    end 
  end
end