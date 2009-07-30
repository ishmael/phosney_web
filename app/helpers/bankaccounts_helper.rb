module BankaccountsHelper
	def bankaccountnumber
		if not @bankaccount.nil?
			if @bankaccount.id.nil?
			0
			else
			@bankaccount.id
			end
		elsif not @account.nil? and @account.kind_of? Bankaccount
			if @account.id.nil?
			0
			else
			@account.id
			end
		end
	end
end
