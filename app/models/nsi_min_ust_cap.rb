class NsiMinUstCap < ActiveRecord::Base
  belongs_to :enterprise
  attr_accessible :date_vvod, :summa
  
  validates_numericality_of :summa, only_integer: true
  validates_date :date_vvod
  
  scope :Sorted, order('date_vvod DESC')
  scope :EnterpriseFor, lambda{|enterprise_id_value|where(:enterprise_id => enterprise_id_value)}
  scope :OnDate, lambda{|date_value|where("date_vvod <= ?",date_value)}
  
  self.per_page = 4 # число строк на страницу для гема пагинации ...
end
