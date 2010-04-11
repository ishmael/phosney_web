#Creates xml with values for Factory Output
#along with their names.
#The values required for building the xml is obtained as parameter factory_data
#It expects an array in which each element as 
#a hash with values for "factory_name" and "factory_output"
xml = Builder::XmlMarkup.new
xml.instruct!   :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.chart do
     if not @month_data.empty?
   xml.series do
     1.upto(Time.days_in_month(Time.now.month,Time.now.year)) {
      |i| xml.value( i,:xid=>i)
      } 
    end

    xml.graphs do
	  	@month_data.group_by(&:account_id).sort.each do |account,ydata|
        account_color = ydata[0].color
        account_name = ydata[0].name
        account_currency = ydata[0].currency
        account_count =0
        ydata.group_by(&:mov_type).sort.each do |movtype,movement|
    	  xml.graph(:gid => account,:title => account_name,:color => account_color ,:visible_in_legend => account_count ==0 ) do
    	        days_of_month = Array.new(Time.days_in_month(Time.now.month,Time.now.year))
              movement.each do |mov|  
                days_of_month[mov.movdate.day-1] = mov.amount*movtype
              end
              days_of_month.each_with_index do |total,days_index|
                if not total.nil? 
                  xml.value(total,:xid=> days_index+1,:description =>  (movtype == -1 ? I18n.t('layout.charts.months_balance.expenses') : I18n.t('layout.charts.months_balance.income') )+ ' '+chart_with_currency(total) )
                end
              end
              account_count+= 1 
          end
  	    end
	    end
    end
	end
end