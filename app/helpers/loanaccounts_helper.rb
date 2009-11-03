module LoanaccountsHelper
	def loanaccountnumber
		if not @loanaccount.nil?
   		@loanaccount.pseudo_id
		elsif not @account.nil? and @account.kind_of? Loanaccount
			@account.pseudo_id
		end
	end
end
