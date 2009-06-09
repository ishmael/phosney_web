#Creates xml with values for Factory Output
#along with their names.
#The values required for building the xml is obtained as parameter factory_data
#It expects an array in which each element as 
#a hash with values for "factory_name" and "factory_output"
xml = Builder::XmlMarkup.new
xml.graph(:caption=>'Expending',:subCaption=>'By Day',:pieSliceDepth=>'30',:showNames=>'1', :decimalPrecision=>'0', :formatNumberScale=>'0', :numberSuffix=>' Units') do
	for item in expending_data
		xml.set(:name=>item[:name],:value=>item[:total])
	end
end
