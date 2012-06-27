# encoding: utf-8
class FormTwoReport < ActiveRecord::Base
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
end