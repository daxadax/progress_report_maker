module ApplicationHelper

  #return a default title
  def title
    base_title = "Ganesh"
    if @title.nil?
      base_title
    else
      "#{base_title}| #{@title}"
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
 
end
