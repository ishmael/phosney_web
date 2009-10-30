#Creates xml with values for Factory Output
#along with their names.
#The values required for building the xml is obtained as parameter factory_data
#It expects an array in which each element as 
#a hash with values for "factory_name" and "factory_output"
xml = Builder::XmlMarkup.new
xml.graph(:caption=>I18n.t('layout.fusioncharts.months_balance.caption'), :subCaption=>I18n.t('layout.fusioncharts.months_balance.subcaption') , :xAxisName=>I18n.t('layout.fusioncharts.months_balance.xAxisName') , :yAxisName=>I18n.t('layout.fusioncharts.months_balance.yAxisName') , :hovercapbg=>'FFECAA' , 
    :hovercapborder=>'F47E00' , :formatNumberScale=>'0' , :decimalPrecision=>'2' , :showvalues=>'0' , :animation=>'1' , :numdivlines=>'3' ,:numVdivlines=>'0' ,:lineThickness=>'3' ) do
   xml.categories do
    1.upto(12) {
      |i| xml.category(:name=> I18n.t('date.month_names')[i] )
      } 
    end
    
	  year_data.group_by(&:mov_type).sort.each do |movtype,movement| 
	    xml.dataset(:seriesname=>  movtype == -1 ? I18n.t('layout.fusioncharts.months_balance.expenses') : I18n.t('layout.fusioncharts.months_balance.income'), :showValue=>'1' ,:color=> movtype == -1 ? 'ff0000': '02ff42' ) do
	      months_in_year = Array.new(12)
        movement.each do |mov|  
          months_in_year[mov.movdate.month-1] = mov.balance
        end
        months_in_year.each do |total|
          total.nil? ? xml.set(:value=>0)  : xml.set(:value=>total )
        end
	  end

end
end