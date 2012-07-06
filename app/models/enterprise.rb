# encoding: utf-8
class Enterprise < ActiveRecord::Base
  belongs_to :user
  has_many   :form_one_reports,   :dependent => :destroy
  has_many   :form_two_reports,   :dependent => :destroy
  has_many   :form_three_reports, :dependent => :destroy
  has_many   :form_four_reports,  :dependent => :destroy
  
  attr_accessible :org_name, 
                  :uch_nomer_plat, 
                  :vid_econom_deyatel ,
                  :organiz_pravo_form ,
                  :organ_upravlen , 
                  :edinic_izmer,
                  :adres                  
  
  validates :uch_nomer_plat, length: { is: 9 }, numericality: true     
  validates :edinic_izmer,   length: { maximum: 20 }
  
  scope :UserAreaFor, lambda{|user_id_value|where(:user_id => user_id_value)}

  self.per_page = 12 # число страниц для гема пагинации ...
  
end