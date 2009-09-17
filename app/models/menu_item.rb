class MenuItem < ActiveRecord::Base
    has_and_belongs_to_many :roles  
    serialize   :sub_menu
end
