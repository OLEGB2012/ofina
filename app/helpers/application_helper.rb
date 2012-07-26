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

  # Выводит в видах суммы с учётом особенностей их представления...
  def display_cell_data(cArrName,cFieldName)
    eval("@"+cArrName).nil? ? "х":eval("@"+cArrName+"."+cFieldName)==0?"-":eval("@"+cArrName+"."+cFieldName)<0?"("+number_with_delimiter(eval("@"+cArrName+"."+cFieldName), delimiter: ' ').to_s+")":number_with_delimiter(eval("@"+cArrName+"."+cFieldName), delimiter: ' ')
  end
  
end