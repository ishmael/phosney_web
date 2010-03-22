#Creates xml with values for Factory Output
#along with their names.
#The values required for building the xml is obtained as parameter factory_data
#It expects an array in which each element as 
#a hash with values for "factory_name" and "factory_output"
xml = Builder::XmlMarkup.new
xml.graph(:caption=>I18n.t('layout.fusioncharts.movements_by_month.caption'), :subCaption=>I18n.t('layout.fusioncharts.movements_by_month.subcaption') , :xAxisName=>I18n.t('layout.fusioncharts.movements_by_month.xAxisName') , :yAxisName=>I18n.t('layout.fusioncharts.movements_by_month.yAxisName') , :hovercapbg=>'FFECAA' , 
    :hovercapborder=>'F47E00' ,:formatNumberScale=>'0' ,:palette => '1', :decimalPrecision=>'2' , :showvalues=>'0' , :animation=>'1' , :numdivlines=>'3' ,:numVdivlines=>'0' ,:lineThickness=>'3' ) do
   xml.categories do
    1.upto(Time.days_in_month(Time.now.month,Time.now.year)) {
      |i| xml.category(:name=>i)
      } 
    end

	  spending_data.group_by(&:name).sort.each do |account,movement| 
	      xml.dataset(:seriesname=>account, :showValue=>'1',:color => "#"+ movement[0].color ) do
	        days_of_month = Array.new(Time.days_in_month(Time.now.month,Time.now.year))
          movement.each do |mov|  
            days_of_month[mov.movdate.day-1] = mov.amount
          end
          days_of_month.each do |total|
            total.nil? ? xml.set(:value=>0) : xml.set(:value=>total )
          end
	    end

	end
end
