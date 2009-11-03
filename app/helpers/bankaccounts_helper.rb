module BankaccountsHelper
	def bankaccountnumber
		if not @bankaccount.nil?
			@bankaccount.pseudo_id
		elsif not @account.nil? and @account.kind_of? Bankaccount
			@account.pseudo_id
		end
	end
end
