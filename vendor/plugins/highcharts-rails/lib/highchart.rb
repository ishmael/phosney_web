require "highchart/hash"

class Highchart
  @@types = ['area', 'areaspline', 'bar', 'column', 'line', 'pie', 'scatter', 'spline','combo']
  @@date_format = "<strong>%A</strong><br /> %m/%d/%Y"
  
	attr_accessor :chart, :colors, :credits, :labels, :lang, :legend, :plotOptions, :point,
	              :series, :subtitle, :symbols, :title, :toolbar, :tooltip, :x_axis, :y_axis,:exporting

  def self.method_missing(m, options={})
    format = options[:format] || 'jquery'
    options.delete(:format)
    
    # create the chart and return it in the format requested
    if @@types.include?(m.to_s)  
      chart = new(options.merge!({:type => m}))
      chart.send(format)
    else
      "#{m} is not a supported chart format, please use one of the following: #{supported_types}."
    end  
  end

  def initialize(options={})
    # override highcharts defaults
    @credits = {
      :enabled => false
    }
  
    # IE7 displays 'null' without this
    @title = {
      :text => ""
    }
    @x_axis = {
      :title => {
        :text => ""
      }
    }
    @y_axis = {
      :title => {
        :text => ""
      }
    }
    
    # define defaults based on chart type
    case options[:type].to_s
    when 'area'
      @chart = {
        :defaultSeriesType => 'area'
      }
    when 'areaspline'
      @chart = {
        :defaultSeriesType => 'areaspline'
      }
    when 'bar'
      @chart = {
        :inverted => true, 
        :defaultSeriesType => 'bar', 
      }
    when 'column'
      @chart = {
        :defaultSeriesType => 'column'
      }
    when 'line'
      @chart = {
        :defaultSeriesType => 'line'
      }
    when 'pie'
      @chart = {
        :defaultSeriesType => 'pie'
      }
    when 'scatter'
      @chart = {
        :defaultSeriesType => 'scatter'
      }
    when 'spline'
      @chart = {
        :defaultSeriesType => 'spline'
      }
    when 'combo'
      @chart = {

      }
    end
    
    # set the options from provided hash
    options.each do |attribute, value|
      if value.is_a?(Hash)
        # if provided a hash attempt to merge with defaults, otherwise just override defaults
        send("#{attribute}=", (send(attribute) || {}).merge_recursive(value)) if self.respond_to?("#{attribute}=")
      else
        send("#{attribute.to_s}=", value) if self.respond_to?("#{attribute}=")
      end
    end  
  end
  
  def self.supported_types
    @@types.join(' ')
  end
  
  def jquery
    "var chart = new Highcharts.Chart({ 
      #{options} 
    });"
  end

  def options
    query_params = instance_variables.sort.map do |var|
      case var.to_s
        
      when '@chart'
        set_chart
      when '@colors'
        set_colors if @colors.is_a?(Array)
      when '@credits'
        set_credits
      when '@labels'
        set_labels
      when '@lang'
        set_lang
      when '@legend'
        set_legend
      when '@plotOptions'
        set_plotOptions
      when '@point'
        set_point
      when '@series'
        set_series
      when '@subtitle'
        set_subtitle
      when '@symbols'
        set_symbols
      when '@title'
        set_title
      when '@toolbar'
        set_toolbar
      when '@tooltip'
        set_tooltip
      when '@x_axis'
        set_x_axis
      when '@y_axis'
        set_y_axis
      when '@exporting'
        set_exporting
      end
    end.compact

    "#{query_params.join(",\n")}" 
  
  end

  private
    def set_chart
      "chart: {
        #{concatenate_attributes(@chart)}
      }"
    end
    
    def set_colors
      "colors: [#{@colors.join(", ")}]"
    end
    
    def set_credits
      "credits: {
        #{concatenate_attributes(@credits)}
      }"
    end
    
    def set_labels
      "labels: {
        #{concatenate_attributes(@labels)}
      }"
    end
    
    def set_lang
      "lang: {
        #{concatenate_attributes(@lang)}
      }"
    end
    
    def set_legend
      "legend: {
      #{concatenate_attributes(@legend)}
			}"
    end
    
    def set_plotOptions
      "plotOptions: {
        #{concatenate_attributes(@plotOptions)}
			}"
    end
    
    def set_point
      "point: {
        #{concatenate_attributes(@point)}
			}"
    end
    
    def set_series
        attrs = Array.new
        @series.each do |series_hash|
          ser = Array.new
          series_hash.each do |key, value|
            if key == 'data'
              ser << "[#{concatenate_attributes(value)}]"
            else
              ser << "#{key}: #{typed_print(value)}"
            end
          end

          attrs << "{#{ser.join(",\n")}}";
        end
      
      "series: [
        #{attrs.join(",\n") + "\n"}
			]"
    end
    

    def set_subtitle
      "subtitle: {
        #{concatenate_attributes(@subtitle)}
			}"
    end
    
    def set_symbols
      "symbols: [#{@symbols.join(", ")}]"
    end
    
    def set_title    
      "title: {  
        #{concatenate_attributes(@title)}
      }"
    end
    
    def set_toolbar   
      "toolbar: {  
        #{concatenate_attributes(@toolbar)}
      }"
    end
    
    def set_tooltip   
      "tooltip: {  
        #{concatenate_attributes(@tooltip)}
      }"
    end
    
    def set_x_axis   
      if @x_axis.is_a?(Hash)
      "xAxis: {  
        #{concatenate_attributes(@x_axis)}
      }"
      elsif @x_axis.is_a?(Array) 
        "xAxis: [  
          #{concatenate_attributes(@x_axis)}
        ]"
      end
    end
    
    def set_y_axis  
      if @y_axis.is_a?(Hash)
          "yAxis: {  
            #{concatenate_attributes(@y_axis)}
          }"
      elsif @y_axis.is_a?(Array) 
          "yAxis: [  
            #{concatenate_attributes(@y_axis)}
          ]"
      end 
    end
    
    def set_exporting
      "exporting: {
      #{concatenate_attributes(@exporting)}
			}"
    end
    
    # generic method that accepts a hash and concatenates its key/value pairs
    def concatenate_attributes(attr)
      if attr.is_a?(Hash)
          attrs = Array.new
          attr.each do |key, value|
            if value.is_a?(Hash)
              attrs << "#{key}: {#{concatenate_attributes(value)}}"
            else          
              attrs << "#{key}: #{typed_print(value)}"
            end
          end
      
          attrs.join(",\n") + "\n"
      elsif attr.is_a?(Array)
        attrs = Array.new
          attr.each do |series_hash|
            ser = Array.new
            series_hash.each do |key, value|
                ser << "#{key}: #{typed_print(value)}"
            end

            attrs << "{#{ser.join(",\n")}}";
          end
          attrs.join(",\n") + "\n"
      end
    end
    
    # method determines if value needs to be surrounded in single quotes
    def typed_print(string)
      if string.is_a?(Hash)
        values = Array.new
        string.each { |key, value| values << "#{key}: #{typed_print(value)}"}
        "{ " + values.join(", ") + "}"
      elsif string.is_a?(Array)
        "[" + string.map { |e| typed_print(e) } .join(", ") + "]"
      elsif string.is_a?(Date)
        "'#{string.strftime(@@date_format)}'"
      elsif string.is_a?(String) && string != 'null' && string.index('function') == nil && string.match('Var') == nil
        "'" + string.gsub(/['"\\\x0]/,'\\\\\0') + "'"
      else
        string
      end
    end
end