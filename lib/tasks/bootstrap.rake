namespace :site do
  desc 'load an data needed as a base in the dev db'
  task :bootstrap => :environment do
    puts "Creating dafault data..."
    
    puts "Creating dafault sparts."
    Sport.create( :name => 'Soccer')
    Sport.create( :name => 'Netball')
    Sport.create( :name => 'Rubgy League')
    Sport.create( :name => 'Water Polo')       
    
    puts "Creating dafault roles."
    Role.create ( :name => 'superuser')
    Role.create ( :name => 'admin')
    Role.create ( :name => 'editor')
    Role.create ( :name => 'producer')
    Role.create ( :name => 'mturk')

    puts "Creating dafault Account."
                                                                               #'p4wy8*jy9i#'    
    u = User.create ( :username => 'reg', :email => 'teeerevor@gmail.com', :password => 'lengine', :password_confirmation => 'lengine')
    a = Account.create( :name => 'Default', :sport_id => Sport.find(1).id, :owner_id => u.id)
    AccountsUser.create(:account_id => a.id, :user_id => u.id, :role_id => 1, :active => 1)

    puts "Creating dafault stat_types."    
    a.stats.create( :entity => 'LeagueStat',  :name => 'played',      :display => "Played",      :short_desc => 'P')
    a.stats.create( :entity => 'LeagueStat',  :name => 'wins',        :display => "Wins",        :short_desc => 'W')
    a.stats.create( :entity => 'LeagueStat',  :name => 'draws',       :display => "Draws",       :short_desc => 'D')
    a.stats.create( :entity => 'LeagueStat',  :name => 'loses',       :display => "Loses",       :short_desc => 'L')
    a.stats.create( :entity => 'LeagueStat',  :name => 'for',         :display => "For",         :short_desc => 'F')
    a.stats.create( :entity => 'LeagueStat',  :name => 'against',     :display => "Against",     :short_desc => 'A')
    a.stats.create( :entity => 'LeagueStat',  :name => 'difference',  :display => "Difference",  :short_desc => 'Diff')
    a.stats.create( :entity => 'LeagueStat',  :name => 'points',      :display => "Points",      :short_desc => 'Pts')
    
    a.stats.create( :entity => 'TeamStat',    :name => 'score',       :display => "Score",        :short_desc => 'Scr')
    
    a.stats.create( :entity => 'PlayerStat',  :name => 'game_played', :display => "Game Played", :short_desc => 'GP')
    a.stats.create( :entity => 'PlayerStat',  :name => 'goal',        :display => "Goal",        :short_desc => 'G' )
    a.stats.create( :entity => 'PlayerStat',  :name => 'goals',       :display => "Goals",        :short_desc => 'Gs')
    a.stats.create( :entity => 'PlayerStat',  :name => 'exclusion',   :display => "Exclusion",    :short_desc => 'Ex')
    a.stats.create( :entity => 'PlayerStat',  :name => 'exclusions',  :display => "Exclusions",    :short_desc => 'Exs')
    
    l = League.create(:account_id => a.id, :name => 'DefaultLeague')
    
    %w|Australia Brazil China Denmark|.each do |team|
      t = Team.create(:name => team)
      
      %w|played wins draws loses for against difference points|.each do |stat|
        LeagueStat.create(:league_id => l.id, :team_id => t.id, :stat_type_id => StatType.find_by_name(stat).id, :value => 0)
      end
    end
    
    puts "Done."
  end
end