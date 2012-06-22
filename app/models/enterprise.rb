# == Schema Information
#
# Table name: enterprises
#
#  id                 :integer         not null, primary key
#  user_id            :integer
#  org_name           :string(255)
#  uch_nomer_plat     :string(9)
#  vid_econom_deyatel :string(255)
#  organiz_pravo_form :string(255)
#  organ_upravlen     :string(255)
#  edinic_izmer       :string(20)
#  adres              :string(255)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#

class Enterprise < ActiveRecord::Base
  belongs_to :user
  attr_accessible :org_name, :uch_nomer_plat, :edinic_izmer
  validates :uch_nomer_plat, length: { minimum: 9 }
  validates :edinic_izmer,   length: { maximum: 20 }
end
