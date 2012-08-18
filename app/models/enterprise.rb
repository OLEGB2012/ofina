# encoding: utf-8
class Enterprise < ActiveRecord::Base
  belongs_to :user
  has_many   :form_one_reports,   :dependent => :destroy
  has_many   :form_two_reports,   :dependent => :destroy
  has_many   :form_three_reports, :dependent => :destroy
  has_many   :form_four_reports,  :dependent => :destroy
  has_many   :analytical_balances,:dependent => :destroy
  has_many   :balanse_rows,       :dependent => :destroy
  
  attr_accessible :org_name, 
                  :uch_nomer_plat, 
                  :vid_econom_deyatel ,
                  :organiz_pravo_form ,
                  :organ_upravlen , 
                  :edinic_izmer,
                  :adres, :K1, :K2, :K3, :rab_date_beg, :rab_date_end                  
  
  validates :uch_nomer_plat, length: { is: 9 }, numericality: true     
  validates :edinic_izmer,   length: { maximum: 20 }
  
  # Валидация из гема validates_timeliness
  validates_date :rab_date_beg, :before => :rab_date_end  
  validates_date :rab_date_end, :after  => :rab_date_beg
  
  validates_numericality_of :K1, :K2, :K3, greater_than_or_equal_to: 0, less_than_or_equal_to: 9.99

  scope :UserAreaFor, lambda{|user_id_value|where(:user_id => user_id_value)}

  self.per_page = 12 # число страниц для гема пагинации ...
  
end