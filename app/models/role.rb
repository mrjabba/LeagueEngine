class Role < ActiveRecord::Base
  has_and_belongs_to_many :menu_items
end
