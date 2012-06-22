# == Schema Information
#
# Table name: enterprises
#
#  id                 :integer         not null, primary key
#  user_id            :integer
#  org_name           :string(255)
#  uch_nomer_plat     :string(255)
#  vid_econom_deyatel :string(255)
#  organiz_pravo_form :string(255)
#  organ_upravlen     :string(255)
#  edinic_izmer       :string(255)
#  adres              :string(255)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#

require 'spec_helper'

describe Enterprise do
  pending "add some examples to (or delete) #{__FILE__}"
end
