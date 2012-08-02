class AnalyticalBalance < ActiveRecord::Base
  belongs_to :enterprise
  
  
  
  attr_accessible :title, :body
  
end
