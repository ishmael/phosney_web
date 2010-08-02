class Search
  attr_reader :options
  
  def initialize(model, options,initial_conditions,initial_parameters)
    @model = model
    @options = options || {}
    @initial_conditions = initial_conditions
    @initial_parameters = initial_parameters
  end
 
  def start_date
    options[:start_date]
  end
 
  def end_date
    options[:end_date]
  end
 
  def max_amount 
    Money.new(options[:max_amount].to_money.cents,currency)
  end
 
  def min_amount
    Money.new(options[:min_amount].to_money.cents,currency)
  end
 
  def description
    options[:description]
  end
 
  def type_mov_hidden
    options[:type_mov_hidden]
  end 
  
  def currency
    options[:currency]
  end
  
  # method_missing will autogenerate an accessor for any attribute other
  # than the methods already written. I love this magic. :)
  def method_missing(method_id, *arguments)
    if @model.column_names.include?(method_id.to_s)
      options[method_id].to_s
    else
      raise NoMethodError, "undefined method #{method_id}"
    end
  end
 
  def conditions
     
    conditions = []
    parameters = []

    return nil if options.empty?
 
    if not start_date.empty?
      conditions << "#{@model.table_name}.movdate >= to_date(?,'DD-MM-YYYY')"
      #conditions << "#{@model.table_name}.movdate >= ?"
      parameters << start_date
    end
 
    if not end_date.empty?
      conditions << "#{@model.table_name}.movdate <= to_date(?,'DD-MM-YYYY')"
      #conditions << "#{@model.table_name}.movdate <= ?"
      parameters << end_date
    end
 
    if min_amount.cents != 0
      conditions << "#{@model.table_name}.amount_in_cents >= ?"
      parameters << min_amount.cents
    end
 
    if max_amount.cents != 0 
      conditions << "#{@model.table_name}.amount_in_cents <= ?"
      parameters << max_amount.cents
    end
    
    if not type_mov_hidden.empty?
      conditions << "#{@model.table_name}.mov_type = ?"
      parameters << type_mov_hidden
    end
 
    # note that we're using self.send to make sure we use the getter methods
    # so that stuff like modem_mac gets its proper formatting in parameters
    options.each_key do |k|
      next unless @model.column_names.include?(k.to_s)
      v = self.send(k) unless k == :conditions # No infinite recursion for you.
      next if v.blank?
      if k =~ /_id$/
        conditions << "#{@model.table_name}.#{k} = ?"
        parameters << v.to_i
      else
        conditions << "UPPER(#{@model.table_name}.#{k}) LIKE UPPER(?)"
        parameters << "%#{v}%"
      end
    end
 
    unless conditions.empty?
      conditions.concat( @initial_conditions)
      parameters.concat(@initial_parameters)
      [conditions.join(" AND "), *parameters]
    else
      nil
    end
  end
end