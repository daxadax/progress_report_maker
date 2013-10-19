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
  
  def avg_to_words(average)
    if average >= 3.5
      "Exceeds expectations"
    elsif (2.75..3.5).include? average 
      "Meets expectations"
    else
      "Struggling"
    end  
  end

  def status(average)
    # set average.nil.to_f to return 0, for use when using as a css class
    if average.to_f >= 3.5
      :exceed
    elsif (2.75..3.5).include? average 
      :meet
    else
      :struggle
    end
  end
  
  def login_or_signup?
    current_page?(:login) || current_page?(:signup)
  end 
  
  def flash_failure
    flash.now[:error] = "Something's gone wrong.  Please try again!"
  end
 
end


