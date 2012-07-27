# encoding: utf-8
class FormTwoReport < ActiveRecord::Base
  before_save :calc_rows_f2, :normalize_end_date  

  belongs_to :enterprise
  
  attr_accessible :date_period_beg, :date_period_end, 
                  :S010, :S020, :S030, :S040, :S050, :S060, :S070, :S080, :S090, 
                  :S100, :S101, :S102, :S103, :S104, :S110, :S111, :S112, :S120,
                  :S121, :S122, :S130, :S131, :S132, :S133, :S140, :S150, :S160,
                  :S170, :S180, :S190, :S200, :S210, :S211, :S212, :S213, :S214,
                  :S220, :S230, :S240, :S250, :S260
                    
  validates :S010, :S020, :S030, :S040, :S050, :S060, :S070, :S080, :S090, 
            :S100, :S101, :S102, :S103, :S104, :S110, :S111, :S112, :S120,
            :S121, :S122, :S130, :S131, :S132, :S133, :S140, :S150, :S160,
            :S170, :S180, :S190, :S200, :S210, :S211, :S212, :S213, :S214,
            :S220, :S230, :S240, :S250, :S260, numericality: true
          
  # Валидация из гема validates_timeliness
  validates_date :date_period_beg, :before => :date_period_end  
  validates_date :date_period_end, :after  => :date_period_beg
  
  
  self.per_page = 4 # число строк на страницу для гема пагинации ...
  
  scope :Sorted, order('form_two_reports.date_period_end DESC')
  scope :FormTwoEnterpriseFor, lambda{|enterprise_id_value|where(:enterprise_id => enterprise_id_value)}
  
  private
  
  # если пройдена валидация, то принудительно ставим конечную дату на тот же год, что и начальная...
  def normalize_end_date    
    self.date_period_end=self.date_period_end.years_ago(self.date_period_end.year-self.date_period_beg.year)
  end
  
  # Расчитаем итоговые строки для формы 2
  def calc_rows_f2
    self.S030 = self.S010-self.S020
    self.S060 = self.S030-self.S040-self.S050
    self.S090 = self.S060+self.S070-self.S080
    self.S100 = self.S101+self.S102+self.S103+self.S104
    self.S110 = self.S111+self.S112
    self.S120 = self.S121+self.S122
    self.S130 = self.S131+self.S132+self.S133
    self.S150 = self.S100-self.S110+self.S120-self.S130+self.S140
    self.S160 = self.S090+self.S150
    self.S210 = self.S160-self.S170+self.S180+self.S190-self.S200
    self.S240 = self.S210+self.S220+self.S230
  end
end