module BankaccountsHelper
	def accountnumber
		if not @bankaccount.nil?
			@bankaccount.id
		end
	end

end
