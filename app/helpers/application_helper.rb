module ApplicationHelper
  def title
    base_title = "Strata Retail - Just Books Community Library Chain"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
