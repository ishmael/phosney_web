class Bankaccount < Account
  
  def self.find_user_bankaccounts(*args)
      with_scope(:find => {:order => "accounts.name asc"}) do
        find(*args)
      end
  end
end
