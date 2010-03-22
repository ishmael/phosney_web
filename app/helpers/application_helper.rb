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
  # HSV values in [0..1[
  # returns [r, g, b] values from 0 to 255
  def hsv_to_rgb(h, s, v)
    h_i = (h*6).to_i
    f = h*6 - h_i
    p = v * (1 - s)
    q = v * (1 - f*s)
    t = v * (1 - (1 - f) * s)
    r, g, b = v, t, p if h_i==0
    r, g, b = q, v, p if h_i==1
    r, g, b = p, v, t if h_i==2
    r, g, b = p, q, v if h_i==3
    r, g, b = t, p, v if h_i==4
    r, g, b = v, p, q if h_i==5
    [(r*256).to_i, (g*256).to_i, (b*256).to_i]
  end
  # generates HTML code for 26 background colors given R, G, B values.
  def gen_colors(ccount)
    golden_ratio_conjugate = 0.618033988749895
    h = rand

    colours = Array.new
    1.upto(ccount).each do |c|
      h += golden_ratio_conjugate
      h %= 1
      r, g, b= hsv_to_rgb(h, 0.5, 0.95)
      colours<<  r.to_s(16) +  g.to_s(16) + b.to_s(16)
    end
    return colours
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