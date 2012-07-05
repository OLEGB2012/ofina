# encoding: utf-8

module ApplicationHelper  
  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = 'Онлайн Финансовый Анализ'
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{get_mode_for_title()}| #{page_title}"
    end
  end

  def get_mode_for_title()
    if user_signed_in?              
      if current_user.admin
         "Административный Режим"
      else 
         "Пользовательский Режим"
      end 
    else 
      "Гостевой Режим"             
    end 
  end  
end