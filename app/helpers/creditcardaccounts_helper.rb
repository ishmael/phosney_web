module CreditcardaccountsHelper

	def creditcardaccountnumber
		if not @creditcardaccount.nil?
  		@creditcardaccount.pseudo_id
		elsif not @account.nil? and @account.kind_of? Creditcardaccount
			@account.pseudo_id
		end
	end
end
