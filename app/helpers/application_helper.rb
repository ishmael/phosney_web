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
  

	
	def currencies(accounts,last)
	  ret = ''
	  currencies = Array.new
	  accounts.each do |conta|
	      currencies << conta.currency
	  end
	  currencies.uniq!
	  
	    currencies.each do |currency_type|
	      ret += 	"<tr class=\""+ cycle('even', 'odd') +"\">"
	      ret +="<th class=\"first\">"+ I18n.t('layout.accounts.total') +"(" + currency_type + ")</th>"
				ret += "<td class=\"tr\">" + format_currency(accounts.find_all{|item| item.currency == currency_type }.sum { |citem| citem.balance }) +"</td>"
				if last 
				  ret+= "<td class=\"last\"></td>"
				end
	      ret += "</tr>"
	    end
	    
    return ret

	end
	
	def format_currency(value)
	  case value.currency
    when 'EUR'
      number_to_currency(value.to_f,{:precision => 2,:unit=> '&euro;'})
    when 'GBP'
      number_to_currency(value.to_f,{:precision => 2,:unit=> '&pound;', :separator => ",", :delimiter => ""})
    when 'USD'
      value.format
    else
      value.format
    end
	end
end
#, :format => '%n%u' , :separator => ',' delimiter => '.'