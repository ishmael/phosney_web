module LoanaccountsHelper
	def loanaccountnumber
		if not @loanaccount.nil?
			if @loanaccount.id.nil?
			0
			else
			@loanaccount.id
			end
		elsif not @account.nil? and @account.kind_of? Loanaccount
			if @account.id.nil?
			0
			else
			@account.id
			end
		end
	end
end
