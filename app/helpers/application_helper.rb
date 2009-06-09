# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    require "fusioncharts_helper"
    include FusionChartsHelper
  def app_title
    "Phosney | Keeping your finances neatly in order.." 
  end
  
  def app_name
    "Phosney"
  end
  
  def app_tag
    "Keeping your finances neatly in order.."
  end
  
  def company_name
    "Phosney"
  end
  
  def last_login
    if (not current_user.last_login_at.nil?)
    current_user.last_login_at.to_s(:long)
    else
    'Never'
    end
  end
  
  def account_selected
    if  not accountnumber.nil? 
      accountnumber
    end
  end
end
