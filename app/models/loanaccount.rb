class Loanaccount < Account
  
  def self.find_user_loanaccounts(*args)
      with_scope(:find => {}) do
        find(*args)
      end
  end
end
