class LeagueStat < ActiveRecord::Base
  belongs_to :team
  belongs_to :league
  belongs_to :stat_type
  
  named_scope :ordered, :include => 'stat_type', :conditions => 'stat_type_id = stat_types.id AND stat_types.display_order IS NOT NULL', :group => 'league_stats.id', :order => 'stat_types.display_order'
  
end