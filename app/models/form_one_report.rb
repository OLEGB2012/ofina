# encoding: utf-8
class FormOneReport < ActiveRecord::Base
  before_save :calc_rows_f1
  #set_table_name("form_one_reports")

  belongs_to :enterprise
  
  attr_accessible :date_period, :S110, :S120, :S130, :S131, :S132, :S133, :S140, :S150, :S160, :S170, :S180, :S190,
                                :S210, :S211, :S212, :S213, :S214, :S215, :S216, :S220, :S230, :S240, :S250, :S260, 
                                :S270, :S280, :S290, :S300, :S410, :S420, :S430, :S440, :S450, :S460, :S470, :S480,
                                :S490, :S510, :S520, :S530, :S540, :S550, :S560, :S590, :S610, :S620, :S630, :S631, 
                                :S632, :S633, :S634, :S635, :S636, :S637, :S638, :S640, :S650, :S660, :S670, :S690, 
                                :S700, :K1,   :K2,   :K3,   :Kabsl,:Kcap, :Kfnez
                    
  validates :S110, :S120, :S130, :S131, :S132, :S133, :S140, :S150, :S160, :S170, :S180, :S190,
            :S210, :S211, :S212, :S213, :S214, :S215, :S216, :S220, :S230, :S240, :S250, :S260, 
            :S270, :S280, :S290, :S300, :S410, :S420, :S430, :S440, :S450, :S460, :S470, :S480,
            :S490, :S510, :S520, :S530, :S540, :S550, :S560, :S590, :S610, :S620, :S630, :S631, 
            :S632, :S633, :S634, :S635, :S636, :S637, :S638, :S640, :S650, :S660, :S670, :S690, 
            :S700, :K1,   :K2,   :K3,   :Kabsl,:Kcap, :Kfnez, numericality: true
  
  # Валидация из гема validates_timeliness
  validates_date :date_period

  self.per_page = 12 # число строк на страницу для гема пагинации ...
  
  scope :Sorted, order('form_one_reports.date_period DESC')
  scope :FormOneEnterpriseFor, lambda{|enterprise_id_value|where(:enterprise_id => enterprise_id_value)}
  scope :WorkPeriod,           lambda{|date_period_1, date_period_2|where("date_period >= ? AND date_period <= ?", date_period_1, date_period_2)} 
  scope :ReportOnDate,         lambda{|date_report|where("date_period = ?", date_report)} 
  
  private
  # Расчитаем итоговые строки для формы 1
  def calc_rows_f1
    self.S130 = self.S131+self.S132+self.S133
    self.S190 = self.S110+self.S120+self.S130+self.S140+self.S150+self.S160+self.S170+self.S180
    self.S210 = self.S211+self.S212+self.S213+self.S214+self.S215+self.S216
    self.S290 = self.S210+self.S220+self.S230+self.S240+self.S250+self.S260+self.S270+self.S280
    self.S300 = self.S190+self.S290
    self.S490 = self.S410-self.S420-self.S430+self.S440+self.S450+self.S460+self.S470+self.S480
    self.S590 = self.S510+self.S520+self.S530+self.S540+self.S550+self.S560
    self.S630 = self.S631+self.S632+self.S633+self.S634+self.S635+self.S636+self.S637+self.S638
    self.S690 = self.S610+self.S620+self.S630+self.S640+self.S650+self.S660+self.S670
    self.S700 = self.S490+self.S590+self.S690
  end  
end