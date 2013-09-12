module ApplicationHelper

  #return a default title
  def title
    base_title = "Ganesh"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end    
  end
  
  def logo
    image_tag("logo.png", :alt => "Ganesh: Generating Progress", :class => "round")
  end

  def pluralize_without_count(count, singular, plural)
    if count != 0
      count == 1 ? "#{singular}" : "#{plural}"
    end
  end
  
  # http://stackoverflow.com/a/17987612/2128691
  def cond_class(condition, true_class, false_class = '')
    condition ? true_class : false_class
  end
  
  def login_or_signup?
    current_page?(:login) || current_page?(:signup)
  end 
  
  def flash_failure
    flash.now[:error] = "Something's gone wrong.  Please try again!"
  end
  
  # get average of scores and round to two decimal places
  def avg(scores)
    average = scores.inject{ |sum, el| sum + el }.to_f / scores.size
    average.round(2)
  end
 
end


