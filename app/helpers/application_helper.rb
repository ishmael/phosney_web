# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    require "fusioncharts_helper"
    include FusionChartsHelper
	
	def accountnumber
		if not @bankaccount.nil?
			@bankaccount.pseudo_id
		elsif not @creditcardaccount.nil?
			@creditcardaccount.pseudo_id
		elsif not @loanaccount.nil?
			@loanaccount.pseudo_id
		elsif not @account.nil? 
			@account.pseudo_id
		end
	end
	
	def accounttype
		if not @bankaccount.nil?
			@bankaccount.class
		elsif not @creditcardaccount.nil?
			@creditcardaccount.class
		elsif not @loanaccount.nil?
			@loanaccount.class
		end
	end
end
