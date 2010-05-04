
xml = Builder::XmlMarkup.new
xml.instruct!   :xml, :version=>"1.0", :encoding=>"UTF-8"

xml.chart do
   xml.series do
      if not @year_data.empty? 
        1.upto(12) {
          |i| xml.value( I18n.t('date.month_names')[i] ,:xid=>i)
      } 
      end
    end
   
    xml.graphs do
            @year_data.group_by(&:id).each do |acc,ydata|
              account_color = ydata[0].color
              account_name = ydata[0].name
              account_currency = ydata[0].currency
              account_count =0
              ydata.group_by(&:mov_type).sort.each do |movtype,movement| 	        
          	    xml.graph(:gid => acc,:title => account_name,:color => account_color ,:visible_in_legend => account_count ==0 ) do
          	      months_in_year = Array.new(12)
                  movement.each do |mov|  
                    months_in_year[mov.movdate.month-1] = mov.amount* movtype
                  end
                  months_in_year.each_with_index do |total,month_index|
                    if not total.nil? 
                       xml.value(total.to_f,:xid=> month_index+1,:description =>  (movtype == -1 ? I18n.t('layout.charts.months_balance.expenses') : I18n.t('layout.charts.months_balance.income') )+ ' '+total.to_chart)
                     end
                  end
                  account_count+= 1              
              end          
      	    end
      end
    end

end
