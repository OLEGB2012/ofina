class AnalyticalBalance < ActiveRecord::Base
  before_save :calc_rows_ab
  
  belongs_to :enterprise
  
  attr_accessible :date_period_beg, :date_period_end, :row_type, :G1, :G2, :G3, :G5, :G4, :G6, :G8, :G9, :G10
  
  scope :ABEnterpriseFor, lambda{|enterprise_id_value|where(:enterprise_id => enterprise_id_value)}
  scope :WorkPeriod, lambda{|date_period_1, date_period_2|where("date_period_beg = ? AND date_period_end = ?", date_period_1, date_period_2)} 

 private
  # Расчитаем итоговые строки для формы
  def calc_rows_ab
    self.G7 = self.G5-self.G3
    self.G8 = self.G6-self.G4
    if self.G3!=0
     self.G9  = (self.G5.to_f/self.G3)*100
     self.G10 = self.G9-100
    end    
  end  
end
