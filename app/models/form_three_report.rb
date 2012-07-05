# encoding: utf-8
class FormThreeReport < ActiveRecord::Base
  before_save :summa_for_g10
  
  belongs_to :enterprise
  
  attr_accessible :date_period_beg, :date_period_end, :G1,:G2,:G3,:G4,:G5,:G6,:G7,:G8,:G9,:G10
    
  validates :G3,:G4,:G5,:G6,:G7,:G8,:G9,:G10, numericality: true
  
  self.per_page = 12 # число страниц для гема пагинации ...
  
  private
  def summa_for_g10
    self.G10 = self.G3+self.G4+self.G5+self.G6+self.G7+self.G8+self.G9
  end
end