module BankaccountsHelper
	def accountnumber
		if not @bankaccount.nil?
			if @bankaccount.id.nil?
			0
			else
			@bankaccount.id
			end
		end
	end

end
