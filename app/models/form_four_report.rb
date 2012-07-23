# encoding: utf-8
class FormFourReport < ActiveRecord::Base
  before_save :calc_rows_f4  

  belongs_to :enterprise
  
  attr_accessible :date_period_beg, :date_period_end, 
                  :S020, :S021, :S022, :S023, :S024, :S030, :S031, :S032, :S033, 
                  :S034, :S040, :S050, :S051, :S052, :S053, :S054, :S055, :S060,
                  :S061, :S062, :S063, :S064, :S070, :S080, :S081, :S082, :S083,
                  :S084, :S090, :S091, :S092, :S093, :S094, :S095, :S100, :S110,
                  :S120, :S130, :S140
                    
  validates :S020, :S021, :S022, :S023, :S024, :S030, :S031, :S032, :S033,
            :S034, :S040, :S050, :S051, :S052, :S053, :S054, :S055, :S060, 
            :S061, :S062, :S063, :S064, :S070, :S080, :S081, :S082, :S083, 
            :S084, :S090, :S091, :S092, :S093, :S094, :S095, :S100, :S110, 
            :S120, :S130, :S140, numericality: true
          
   # Валидация из гема validates_timeliness
  validates_date :date_period_beg, :before => :date_period_end  
  validates_date :date_period_end, :after  => :date_period_beg
  
  self.per_page = 12 # число страниц для гема пагинации ...
  
  scope :Sorted, order('form_four_reports.date_period_end DESC')
  scope :FormFourEnterpriseFor, lambda{|enterprise_id_value|where(:enterprise_id => enterprise_id_value)}
  
  private
  # Расчитаем итоговые строки для формы 4
  def calc_rows_f4
    self.S020 = self.S021+self.S022+self.S023+self.S024
    self.S030 = self.S031+self.S032+self.S033+self.S034
    self.S040 = self.S020-self.S030
    self.S050 = self.S051+self.S052+self.S053+self.S054+self.S055
    self.S060 = self.S061+self.S062+self.S063+self.S064
    self.S070 = self.S050-self.S060
    self.S080 = self.S081+self.S082+self.S083+self.S084
    self.S090 = self.S091+self.S092+self.S093+self.S094+self.S095
    self.S100 = self.S080-self.S090
    self.S110 = self.S040+self.S070+self.S100
    self.S130 = self.S110+self.S120
  end
end