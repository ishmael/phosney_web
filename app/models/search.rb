class Search
  attr_reader :options
 
  def initialize(model, options)
    @model = model
    @options = options || {}
  end
 
  def start_date
    date_from_options(:start_date)
  end
 
  def end_date
    date_from_options(:end_date)
  end
 
  def max_amount 
    date_from_options(:max_amount)
  end
 
  def min_amount
    date_from_options(:min_amount)
  end
 
  def description
    options[:description]
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
 
    if start_date
      conditions << "#{@model.table_name}.movdate >= ?"
      parameters << start_date
    end
 
    if end_date
      conditions << "#{@model.table_name}.movdate <= ?"
      parameters << end_date
    end
 
    if min_amount
      conditions << "#{@model.table_name}.amount_in_cents >= ?"
      parameters << min_amount
    end
 
    if max_amount
      conditions << "#{@model.table_name}.amount_in_cents <= ?"
      parameters << max_amount
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
        conditions << "#{@model.table_name}.#{k} LIKE ?"
        parameters << "%#{v}%"
      end
    end
 
    unless conditions.empty?
      [conditions.join(" AND "), *parameters]
    else
      nil
    end
  end
 
  private
 
  # Just like the one in the Report model, but just for dates instead of times.
  # Using a Proc to generate input parameter names like those for date_select.
  def date_from_options(which)
    part = Proc.new { |n| options["#{which}(#{n}i)"] }
    y,m,d = part[1], part[2], part[3]
    y = Date.today.year if y.blank?
    Date.new(y.to_i, m.to_i, d.to_i)
  rescue ArgumentError => e
    return nil
  end
end