class Bankaccount < Account
  
  def self.find_user_bankaccounts(*args)
      with_scope(:find => {}) do
        find(*args)
      end
  end
end
