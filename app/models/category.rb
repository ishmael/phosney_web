class Category < ActiveRecord::Base

  belongs_to :user
  has_many :categories_users, :dependent => :destroy
  has_many :movements, :dependent => :nullify
  has_many :users, :through => :categories_users
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :user_id , :message =>  I18n.t('layout.categories.duplicate')
  default_scope :order => :name




  def self.shared(*args)
      with_scope(:find => {:select => "categories.id, case when categories.user_id = categories_users.user_id then categories.name else categories.name || '(' || (select users.login from users where users.id = categories.user_id) || ')' end as name,categories.user_id,categories.created_at,categories.updated_at,categories.parent_id,categories.mobile" }) do
         find(*args)
      end
  end

  def self.sharedcats(args= {})
      month_difference = 0
      sql = "select categories.id,
    	categories.parent_id,
    	categories.user_id ,
    	cate_moves.account_id,
    	cate_moves.currency,
    	coalesce((select sum(amount_in_cents*mov_type) from movements where movements.category_id = categories.id and movements.account_id = cate_moves.account_id and  date_trunc('month',movdate) = date_trunc('month',now() + (:month + -5) * interval '1 month') ),0) as month5,
    	coalesce((select sum(amount_in_cents*mov_type) from movements where movements.category_id = categories.id and movements.account_id = cate_moves.account_id and  date_trunc('month',movdate) = date_trunc('month',now() + (:month + -4) * interval '1 month') ),0) as month4,
    	coalesce((select sum(amount_in_cents*mov_type) from movements where movements.category_id = categories.id and movements.account_id = cate_moves.account_id and  date_trunc('month',movdate) = date_trunc('month',now() + (:month + -3) * interval '1 month') ),0) as month3,
    	coalesce((select sum(amount_in_cents*mov_type) from movements where movements.category_id = categories.id and movements.account_id = cate_moves.account_id and  date_trunc('month',movdate) = date_trunc('month',now() + (:month + -2) * interval '1 month') ),0) as month2,
    	coalesce((select sum(amount_in_cents*mov_type) from movements where movements.category_id = categories.id and movements.account_id = cate_moves.account_id and  date_trunc('month',movdate) = date_trunc('month',now() + (:month + -1) * interval '1 month') ),0) as month1,
    	coalesce((select sum(amount_in_cents*mov_type) from movements where movements.category_id = categories.id and movements.account_id = cate_moves.account_id and  date_trunc('month',movdate) = date_trunc('month',now() + :month * interval '1 month') ),0) as month0,
    	case when categories.user_id = categories_users.user_id then categories.name else categories.name || '(' || (select users.login from users where users.id = categories.user_id) || ')' end as name,
    	cate_moves.name as account_name,
    	cate_moves.color from categories   INNER JOIN categories_users ON categories.id = categories_users.category_id 
    	  left outer join (select account_id,category_id  ,accounts.currency,accounts.name,accounts.color from movements ,accounts
        	where category_id is not null and date_trunc('month',movdate) between date_trunc('month',CURRENT_TIMESTAMP + (:month +  -5) * interval '1 month') and date_trunc('month',CURRENT_TIMESTAMP + (:month ) * interval '1 month') and accounts.id = movements.account_id
        	group by account_id,category_id,accounts.currency,accounts.name,accounts.color ) cate_moves on categories.id = cate_moves.category_id"
              
      sql += " WHERE " + sanitize_sql(args[:conditions])  if(args[:conditions])
      
      sql += " ORDER BY categories.name" 
      
      month_difference = args[:month_difference]   if(args[:month_difference] and args[:month_difference] != "0") 

    	find_by_sql( [sql,{:month=> month_difference}])
  	
  end

  def parent_id=(parent)
    if parent  == "0" 
      write_attribute(:parent_id,nil)
    else
      write_attribute(:parent_id, parent)
    end
  end

  def parent_id
    parent = read_attribute(:parent_id)
    if parent  == "0" 
      nil
    else
      parent
    end
  end
  
 
  

  def pseudo_id
    new_record? ? 0 : id
  end
end
