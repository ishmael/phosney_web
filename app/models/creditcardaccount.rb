class Creditcardaccount < Account
  
  def self.find_user_creditcardsaccounts(*args)
      with_scope(:find => {}) do
        find(*args)
      end
  end
end
