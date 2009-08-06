# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    require "fusioncharts_helper"
    include FusionChartsHelper

  
  def company_name
    "Phosney"
  end
  
  def last_login
    if (not current_user.last_login_at.nil?)
     l current_user.last_login_at, :format => :long
    else
    'Never'
    end
  end


    def tree_select(categories, model, name, selected=0, level=0, init=true)
    html = ""
    # The "Root" option is added
    # so the user can choose a parent_id of 0
    if init
        # Add "Root" to the options
        html << "<select name=\"#{model}[#{name}]\" id=\"#{model}_#{name}\">\n"
        html << "\t<option value=\"0\""
        html << " selected=\"selected\"" if selected.parent_id == 0
        html << ">Root</option>\n"
    end

    if categories.length > 0
      level += 1 # keep position
      categories.collect do |cat|
        html << "\t<option value=\"#{cat.id}\" style=\"padding-left:#{level * 10}px\""
        html << ' selected="selected"' if cat.id == selected.parent_id
        html << ">#{cat.name}</option>\n"
        html << tree_select(cat.children, model, name, selected, level, false)
      end
    end
    html << "</select>\n" if init
    return html
  end

end
