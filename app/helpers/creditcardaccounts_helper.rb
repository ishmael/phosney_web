module CreditcardaccountsHelper
	def creditcardaccountnumber
		if not @creditcardaccount.nil?
			if @creditcardaccount.id.nil?
			0
			else
			@creditcardaccount.id
			end
		elsif not @account.nil? and @account.kind_of? Creditcardaccount
			if @account.id.nil?
			0
			else
			@account.id
			end
		end
	end
end
