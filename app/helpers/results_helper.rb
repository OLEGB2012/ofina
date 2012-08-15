# encoding: utf-8
module ResultsHelper
   # Выводит суммы с учётом особенностей их представления (используется только в экранах просмотра Результатов)...
  def display_result_data(eVar)
    eVar.nil? ? "х":eVar==0?"-":eVar<0?"("+number_with_delimiter(eVar, delimiter: ' ').to_s+")":number_with_delimiter(eVar, delimiter: ' ')
  end
end
