class Permissions
  attr_reader :menu
  attr_reader :active_acc
  
  def initilise
    empty!
  end
  
  def empty!
    @menu = []
    active_acc = null
  end

  def update
    user = session['user'].id
                       
    active_acc = accounts_user.find(:all,
                              :conditions => ["active = 1 and user_id = :user" ,
                              {:user => user}])
                              
    @menu = menu_items.find(:name,
                       :conditions => ["mir.role_id = :role", 
                       {:role => active_acc.role_id}],
                       :joins => "as mi outer join menu_items_roles as mir on mir.menu_item_id = mi.id" )
  end
end