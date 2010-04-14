# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	
	def currencies(currencies,accounts,last)
	  ret = ''
	    currencies.each do |currency_type|
	      value = accounts.find_all{|item| item.currency == currency_type }.sum { |citem| citem.balance }
	      ret += 	"<tr class=\""+ cycle('even', 'odd') +"\">"
	      ret +="<th class=\"first\">"+ I18n.t('layout.accounts.total') +"(" + currency_type + ")</th>"
				ret += "<td class=\"tr\">" + value.format 
				ret+="</td>"
				if last 
				  ret+= "<td class=\"last\"></td>"
				end
	      ret += "</tr>"
	    end
	    
    return ret

	end
	
end