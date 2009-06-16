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
  
  def account_selected
    if  not accountnumber.nil? 
      accountnumber
    end
  end
end
