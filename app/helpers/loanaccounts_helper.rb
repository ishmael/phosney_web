module LoanaccountsHelper
	def loanaccountnumber
		if not @loanaccount.nil?
			if @loanaccount.id.nil?
			0
			else
			@loanaccount.id
			end
		end
	end
end
