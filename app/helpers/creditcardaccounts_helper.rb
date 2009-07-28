module CreditcardaccountsHelper
	def creditcardaccountnumber
		if not @creditcardaccount.nil?
			if @creditcardaccount.id.nil?
			0
			else
			@creditcardaccount.id
			end
		end
	end
end
