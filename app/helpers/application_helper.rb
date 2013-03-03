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

end
