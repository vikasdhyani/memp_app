module PlansHelper
  def rupee_part(amount)
    amount.to_i
  end

  def paise_part(amount)
    if ((amount - amount.to_i)*100).to_i > 0 
      '.%02d' % ((amount - amount.to_i)*100).to_i
    else
      ''
    end
  end

  def free_months(signUpMonths)
    freeMonths = signUpMonths/6
  end

  def effective_reading_fee(monthlyReadingFee, signUpMonths)
    if signUpMonths > 0  
      payMonths = signUpMonths - free_months(signUpMonths)
      (monthlyReadingFee * payMonths)/(signUpMonths)
    else
      monthlyReadingFee
    end
  end
  
  def plan_button_link_to(name, options = {})
    html_options = {:class => 'plan-button'}		
    html_options.merge!({ :class => 'plan-button plan-button-current' }) if current_page?(options)
    html_options.merge!({ :class => 'plan-button plan-button-current' }) if (params[:signUpMonths].nil? && name.eql?('Monthly'))
    link_to name, options, html_options    
  end

  def find_duration(months)
     duration = case months.to_i
       when 12 then "1 Year"
       when 1 then "1 Month"
       when 0 then "Non Subscription Plan"
       else months.to_s + " Months"
     end
  end

end
