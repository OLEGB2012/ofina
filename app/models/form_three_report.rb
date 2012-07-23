# encoding: utf-8
class FormThreeReport < ActiveRecord::Base
  before_save :summa_for_g10
  
  belongs_to :enterprise
  
  attr_accessible :date_period_beg, :date_period_end, 
      :G3_S010, :G4_S010, :G5_S010, :G6_S010, :G7_S010, :G8_S010, :G9_S010, :G10_S010,
      :G3_S020, :G4_S020, :G5_S020, :G6_S020, :G7_S020, :G8_S020, :G9_S020, :G10_S020,
      :G3_S030, :G4_S030, :G5_S030, :G6_S030, :G7_S030, :G8_S030, :G9_S030, :G10_S030,
      :G3_S040, :G4_S040, :G5_S040, :G6_S040, :G7_S040, :G8_S040, :G9_S040, :G10_S040,
      :G3_S050, :G4_S050, :G5_S050, :G6_S050, :G7_S050, :G8_S050, :G9_S050, :G10_S050,
      :G3_S051, :G4_S051, :G5_S051, :G6_S051, :G7_S051, :G8_S051, :G9_S051, :G10_S051,
      :G3_S052, :G4_S052, :G5_S052, :G6_S052, :G7_S052, :G8_S052, :G9_S052, :G10_S052,
      :G3_S053, :G4_S053, :G5_S053, :G6_S053, :G7_S053, :G8_S053, :G9_S053, :G10_S053,
      :G3_S054, :G4_S054, :G5_S054, :G6_S054, :G7_S054, :G8_S054, :G9_S054, :G10_S054,
      :G3_S055, :G4_S055, :G5_S055, :G6_S055, :G7_S055, :G8_S055, :G9_S055, :G10_S055,
      :G3_S056, :G4_S056, :G5_S056, :G6_S056, :G7_S056, :G8_S056, :G9_S056, :G10_S056,
      :G3_S057, :G4_S057, :G5_S057, :G6_S057, :G7_S057, :G8_S057, :G9_S057, :G10_S057,
      :G3_S058, :G4_S058, :G5_S058, :G6_S058, :G7_S058, :G8_S058, :G9_S058, :G10_S058,
      :G3_S059, :G4_S059, :G5_S059, :G6_S059, :G7_S059, :G8_S059, :G9_S059, :G10_S059,
      :G3_S060, :G4_S060, :G5_S060, :G6_S060, :G7_S060, :G8_S060, :G9_S060, :G10_S060,
      :G3_S061, :G4_S061, :G5_S061, :G6_S061, :G7_S061, :G8_S061, :G9_S061, :G10_S061,
      :G3_S062, :G4_S062, :G5_S062, :G6_S062, :G7_S062, :G8_S062, :G9_S062, :G10_S062,
      :G3_S063, :G4_S063, :G5_S063, :G6_S063, :G7_S063, :G8_S063, :G9_S063, :G10_S063,
      :G3_S064, :G4_S064, :G5_S064, :G6_S064, :G7_S064, :G8_S064, :G9_S064, :G10_S064,
      :G3_S065, :G4_S065, :G5_S065, :G6_S065, :G7_S065, :G8_S065, :G9_S065, :G10_S065,
      :G3_S066, :G4_S066, :G5_S066, :G6_S066, :G7_S066, :G8_S066, :G9_S066, :G10_S066,
      :G3_S067, :G4_S067, :G5_S067, :G6_S067, :G7_S067, :G8_S067, :G9_S067, :G10_S067,
      :G3_S068, :G4_S068, :G5_S068, :G6_S068, :G7_S068, :G8_S068, :G9_S068, :G10_S068,
      :G3_S069, :G4_S069, :G5_S069, :G6_S069, :G7_S069, :G8_S069, :G9_S069, :G10_S069,
      :G3_S070, :G4_S070, :G5_S070, :G6_S070, :G7_S070, :G8_S070, :G9_S070, :G10_S070,
      :G3_S080, :G4_S080, :G5_S080, :G6_S080, :G7_S080, :G8_S080, :G9_S080, :G10_S080,
      :G3_S090, :G4_S090, :G5_S090, :G6_S090, :G7_S090, :G8_S090, :G9_S090, :G10_S090,
      :G3_S100, :G4_S100, :G5_S100, :G6_S100, :G7_S100, :G8_S100, :G9_S100, :G10_S100,
      :G3_S110, :G4_S110, :G5_S110, :G6_S110, :G7_S110, :G8_S110, :G9_S110, :G10_S110,
      :G3_S120, :G4_S120, :G5_S120, :G6_S120, :G7_S120, :G8_S120, :G9_S120, :G10_S120,
      :G3_S130, :G4_S130, :G5_S130, :G6_S130, :G7_S130, :G8_S130, :G9_S130, :G10_S130,
      :G3_S140, :G4_S140, :G5_S140, :G6_S140, :G7_S140, :G8_S140, :G9_S140, :G10_S140,
      :G3_S150, :G4_S150, :G5_S150, :G6_S150, :G7_S150, :G8_S150, :G9_S150, :G10_S150,
      :G3_S151, :G4_S151, :G5_S151, :G6_S151, :G7_S151, :G8_S151, :G9_S151, :G10_S151,
      :G3_S152, :G4_S152, :G5_S152, :G6_S152, :G7_S152, :G8_S152, :G9_S152, :G10_S152,
      :G3_S153, :G4_S153, :G5_S153, :G6_S153, :G7_S153, :G8_S153, :G9_S153, :G10_S153,
      :G3_S154, :G4_S154, :G5_S154, :G6_S154, :G7_S154, :G8_S154, :G9_S154, :G10_S154,
      :G3_S155, :G4_S155, :G5_S155, :G6_S155, :G7_S155, :G8_S155, :G9_S155, :G10_S155,
      :G3_S156, :G4_S156, :G5_S156, :G6_S156, :G7_S156, :G8_S156, :G9_S156, :G10_S156,
      :G3_S157, :G4_S157, :G5_S157, :G6_S157, :G7_S157, :G8_S157, :G9_S157, :G10_S157,
      :G3_S158, :G4_S158, :G5_S158, :G6_S158, :G7_S158, :G8_S158, :G9_S158, :G10_S158,
      :G3_S159, :G4_S159, :G5_S159, :G6_S159, :G7_S159, :G8_S159, :G9_S159, :G10_S159,
      :G3_S160, :G4_S160, :G5_S160, :G6_S160, :G7_S160, :G8_S160, :G9_S160, :G10_S160,
      :G3_S161, :G4_S161, :G5_S161, :G6_S161, :G7_S161, :G8_S161, :G9_S161, :G10_S161,
      :G3_S162, :G4_S162, :G5_S162, :G6_S162, :G7_S162, :G8_S162, :G9_S162, :G10_S162,
      :G3_S163, :G4_S163, :G5_S163, :G6_S163, :G7_S163, :G8_S163, :G9_S163, :G10_S163,
      :G3_S164, :G4_S164, :G5_S164, :G6_S164, :G7_S164, :G8_S164, :G9_S164, :G10_S164,
      :G3_S165, :G4_S165, :G5_S165, :G6_S165, :G7_S165, :G8_S165, :G9_S165, :G10_S165,
      :G3_S166, :G4_S166, :G5_S166, :G6_S166, :G7_S166, :G8_S166, :G9_S166, :G10_S166,
      :G3_S167, :G4_S167, :G5_S167, :G6_S167, :G7_S167, :G8_S167, :G9_S167, :G10_S167,
      :G3_S168, :G4_S168, :G5_S168, :G6_S168, :G7_S168, :G8_S168, :G9_S168, :G10_S168,
      :G3_S169, :G4_S169, :G5_S169, :G6_S169, :G7_S169, :G8_S169, :G9_S169, :G10_S169,
      :G3_S170, :G4_S170, :G5_S170, :G6_S170, :G7_S170, :G8_S170, :G9_S170, :G10_S170,
      :G3_S180, :G4_S180, :G5_S180, :G6_S180, :G7_S180, :G8_S180, :G9_S180, :G10_S180,
      :G3_S190, :G4_S190, :G5_S190, :G6_S190, :G7_S190, :G8_S190, :G9_S190, :G10_S190,
      :G3_S200, :G4_S200, :G5_S200, :G6_S200, :G7_S200, :G8_S200, :G9_S200, :G10_S200
    
  validates :G3_S010, :G4_S010, :G5_S010, :G6_S010, :G7_S010, :G8_S010, :G9_S010, :G10_S010,
      :G3_S020, :G4_S020, :G5_S020, :G6_S020, :G7_S020, :G8_S020, :G9_S020, :G10_S020,
      :G3_S030, :G4_S030, :G5_S030, :G6_S030, :G7_S030, :G8_S030, :G9_S030, :G10_S030,
      :G3_S040, :G4_S040, :G5_S040, :G6_S040, :G7_S040, :G8_S040, :G9_S040, :G10_S040,
      :G3_S050, :G4_S050, :G5_S050, :G6_S050, :G7_S050, :G8_S050, :G9_S050, :G10_S050,
      :G3_S051, :G4_S051, :G5_S051, :G6_S051, :G7_S051, :G8_S051, :G9_S051, :G10_S051,
      :G3_S052, :G4_S052, :G5_S052, :G6_S052, :G7_S052, :G8_S052, :G9_S052, :G10_S052,
      :G3_S053, :G4_S053, :G5_S053, :G6_S053, :G7_S053, :G8_S053, :G9_S053, :G10_S053,
      :G3_S054, :G4_S054, :G5_S054, :G6_S054, :G7_S054, :G8_S054, :G9_S054, :G10_S054,
      :G3_S055, :G4_S055, :G5_S055, :G6_S055, :G7_S055, :G8_S055, :G9_S055, :G10_S055,
      :G3_S056, :G4_S056, :G5_S056, :G6_S056, :G7_S056, :G8_S056, :G9_S056, :G10_S056,
      :G3_S057, :G4_S057, :G5_S057, :G6_S057, :G7_S057, :G8_S057, :G9_S057, :G10_S057,
      :G3_S058, :G4_S058, :G5_S058, :G6_S058, :G7_S058, :G8_S058, :G9_S058, :G10_S058,
      :G3_S059, :G4_S059, :G5_S059, :G6_S059, :G7_S059, :G8_S059, :G9_S059, :G10_S059,
      :G3_S060, :G4_S060, :G5_S060, :G6_S060, :G7_S060, :G8_S060, :G9_S060, :G10_S060,
      :G3_S061, :G4_S061, :G5_S061, :G6_S061, :G7_S061, :G8_S061, :G9_S061, :G10_S061,
      :G3_S062, :G4_S062, :G5_S062, :G6_S062, :G7_S062, :G8_S062, :G9_S062, :G10_S062,
      :G3_S063, :G4_S063, :G5_S063, :G6_S063, :G7_S063, :G8_S063, :G9_S063, :G10_S063,
      :G3_S064, :G4_S064, :G5_S064, :G6_S064, :G7_S064, :G8_S064, :G9_S064, :G10_S064,
      :G3_S065, :G4_S065, :G5_S065, :G6_S065, :G7_S065, :G8_S065, :G9_S065, :G10_S065,
      :G3_S066, :G4_S066, :G5_S066, :G6_S066, :G7_S066, :G8_S066, :G9_S066, :G10_S066,
      :G3_S067, :G4_S067, :G5_S067, :G6_S067, :G7_S067, :G8_S067, :G9_S067, :G10_S067,
      :G3_S068, :G4_S068, :G5_S068, :G6_S068, :G7_S068, :G8_S068, :G9_S068, :G10_S068,
      :G3_S069, :G4_S069, :G5_S069, :G6_S069, :G7_S069, :G8_S069, :G9_S069, :G10_S069,
      :G3_S070, :G4_S070, :G5_S070, :G6_S070, :G7_S070, :G8_S070, :G9_S070, :G10_S070,
      :G3_S080, :G4_S080, :G5_S080, :G6_S080, :G7_S080, :G8_S080, :G9_S080, :G10_S080,
      :G3_S090, :G4_S090, :G5_S090, :G6_S090, :G7_S090, :G8_S090, :G9_S090, :G10_S090,
      :G3_S100, :G4_S100, :G5_S100, :G6_S100, :G7_S100, :G8_S100, :G9_S100, :G10_S100,
      :G3_S110, :G4_S110, :G5_S110, :G6_S110, :G7_S110, :G8_S110, :G9_S110, :G10_S110,
      :G3_S120, :G4_S120, :G5_S120, :G6_S120, :G7_S120, :G8_S120, :G9_S120, :G10_S120,
      :G3_S130, :G4_S130, :G5_S130, :G6_S130, :G7_S130, :G8_S130, :G9_S130, :G10_S130,
      :G3_S140, :G4_S140, :G5_S140, :G6_S140, :G7_S140, :G8_S140, :G9_S140, :G10_S140,
      :G3_S150, :G4_S150, :G5_S150, :G6_S150, :G7_S150, :G8_S150, :G9_S150, :G10_S150,
      :G3_S151, :G4_S151, :G5_S151, :G6_S151, :G7_S151, :G8_S151, :G9_S151, :G10_S151,
      :G3_S152, :G4_S152, :G5_S152, :G6_S152, :G7_S152, :G8_S152, :G9_S152, :G10_S152,
      :G3_S153, :G4_S153, :G5_S153, :G6_S153, :G7_S153, :G8_S153, :G9_S153, :G10_S153,
      :G3_S154, :G4_S154, :G5_S154, :G6_S154, :G7_S154, :G8_S154, :G9_S154, :G10_S154,
      :G3_S155, :G4_S155, :G5_S155, :G6_S155, :G7_S155, :G8_S155, :G9_S155, :G10_S155,
      :G3_S156, :G4_S156, :G5_S156, :G6_S156, :G7_S156, :G8_S156, :G9_S156, :G10_S156,
      :G3_S157, :G4_S157, :G5_S157, :G6_S157, :G7_S157, :G8_S157, :G9_S157, :G10_S157,
      :G3_S158, :G4_S158, :G5_S158, :G6_S158, :G7_S158, :G8_S158, :G9_S158, :G10_S158,
      :G3_S159, :G4_S159, :G5_S159, :G6_S159, :G7_S159, :G8_S159, :G9_S159, :G10_S159,
      :G3_S160, :G4_S160, :G5_S160, :G6_S160, :G7_S160, :G8_S160, :G9_S160, :G10_S160,
      :G3_S161, :G4_S161, :G5_S161, :G6_S161, :G7_S161, :G8_S161, :G9_S161, :G10_S161,
      :G3_S162, :G4_S162, :G5_S162, :G6_S162, :G7_S162, :G8_S162, :G9_S162, :G10_S162,
      :G3_S163, :G4_S163, :G5_S163, :G6_S163, :G7_S163, :G8_S163, :G9_S163, :G10_S163,
      :G3_S164, :G4_S164, :G5_S164, :G6_S164, :G7_S164, :G8_S164, :G9_S164, :G10_S164,
      :G3_S165, :G4_S165, :G5_S165, :G6_S165, :G7_S165, :G8_S165, :G9_S165, :G10_S165,
      :G3_S166, :G4_S166, :G5_S166, :G6_S166, :G7_S166, :G8_S166, :G9_S166, :G10_S166,
      :G3_S167, :G4_S167, :G5_S167, :G6_S167, :G7_S167, :G8_S167, :G9_S167, :G10_S167,
      :G3_S168, :G4_S168, :G5_S168, :G6_S168, :G7_S168, :G8_S168, :G9_S168, :G10_S168,
      :G3_S169, :G4_S169, :G5_S169, :G6_S169, :G7_S169, :G8_S169, :G9_S169, :G10_S169,
      :G3_S170, :G4_S170, :G5_S170, :G6_S170, :G7_S170, :G8_S170, :G9_S170, :G10_S170,
      :G3_S180, :G4_S180, :G5_S180, :G6_S180, :G7_S180, :G8_S180, :G9_S180, :G10_S180,
      :G3_S190, :G4_S190, :G5_S190, :G6_S190, :G7_S190, :G8_S190, :G9_S190, :G10_S190,
      :G3_S200, :G4_S200, :G5_S200, :G6_S200, :G7_S200, :G8_S200, :G9_S200, :G10_S200, numericality: true
  
  # Валидация из гема validates_timeliness
  validates_date :date_period_beg, :before => :date_period_end  
  validates_date :date_period_end, :after  => :date_period_beg
  
  self.per_page = 12 # число страниц для гема пагинации ...
  
  scope :Sorted, order('form_three_reports.date_period_end DESC')
  scope :FormThreeEnterpriseFor, lambda{|enterprise_id_value|where(:enterprise_id => enterprise_id_value)}
  
  private
  def summa_for_g10
      
      self.G3_S040 = self.G3_S010+self.G3_S020+self.G3_S030
      self.G4_S040 = self.G4_S010+self.G4_S020+self.G4_S030
      self.G5_S040 = self.G5_S010+self.G5_S020+self.G5_S030
      self.G6_S040 = self.G6_S010+self.G6_S020+self.G6_S030
      self.G7_S040 = self.G7_S010+self.G7_S020+self.G7_S030
      self.G8_S040 = self.G8_S010+self.G8_S020+self.G8_S030
      self.G9_S040 = self.G9_S010+self.G9_S020+self.G9_S030
    
      self.G3_S050 = self.G3_S051+self.G3_S052+self.G3_S053+self.G3_S054+self.G3_S055+self.G3_S056+self.G3_S057+self.G3_S057+self.G3_S059
      self.G4_S050 = self.G4_S051+self.G4_S052+self.G4_S053+self.G4_S054+self.G4_S055+self.G4_S056+self.G4_S057+self.G4_S057+self.G4_S059
      self.G5_S050 = self.G5_S051+self.G5_S052+self.G5_S053+self.G5_S054+self.G5_S055+self.G5_S056+self.G5_S057+self.G5_S057+self.G5_S059
      self.G6_S050 = self.G6_S051+self.G6_S052+self.G6_S053+self.G6_S054+self.G6_S055+self.G6_S056+self.G6_S057+self.G6_S057+self.G6_S059
      self.G7_S050 = self.G7_S051+self.G7_S052+self.G7_S053+self.G7_S054+self.G7_S055+self.G7_S056+self.G7_S057+self.G7_S057+self.G7_S059
      self.G8_S050 = self.G8_S051+self.G8_S052+self.G8_S053+self.G8_S054+self.G8_S055+self.G8_S056+self.G8_S057+self.G8_S057+self.G8_S059
      self.G9_S050 = self.G9_S051+self.G9_S052+self.G9_S053+self.G9_S054+self.G9_S055+self.G9_S056+self.G9_S057+self.G9_S057+self.G9_S059
      
      self.G3_S060 = self.G3_S061+self.G3_S062+self.G3_S063+self.G3_S064+self.G3_S065+self.G3_S066+self.G3_S067+self.G3_S067+self.G3_S069
      self.G4_S060 = self.G4_S061+self.G4_S062+self.G4_S063+self.G4_S064+self.G4_S065+self.G4_S066+self.G4_S067+self.G4_S067+self.G4_S069
      self.G5_S060 = self.G5_S061+self.G5_S062+self.G5_S063+self.G5_S064+self.G5_S065+self.G5_S066+self.G5_S067+self.G5_S067+self.G5_S069
      self.G6_S060 = self.G6_S061+self.G6_S062+self.G6_S063+self.G6_S064+self.G6_S065+self.G6_S066+self.G6_S067+self.G6_S067+self.G6_S069
      self.G7_S060 = self.G7_S061+self.G7_S062+self.G7_S063+self.G7_S064+self.G7_S065+self.G7_S066+self.G7_S067+self.G7_S067+self.G7_S069
      self.G8_S060 = self.G8_S061+self.G8_S062+self.G8_S063+self.G8_S064+self.G8_S065+self.G8_S066+self.G8_S067+self.G8_S067+self.G8_S069
      self.G9_S060 = self.G9_S061+self.G9_S062+self.G9_S063+self.G9_S064+self.G9_S065+self.G9_S066+self.G9_S067+self.G9_S067+self.G9_S069
      
      self.G3_S100 = self.G3_S040+self.G3_S050-self.G3_S060+self.G3_S070+self.G3_S080+self.G3_S090
      self.G4_S100 = self.G4_S040+self.G4_S050-self.G4_S060+self.G4_S070+self.G4_S080+self.G4_S090
      self.G5_S100 = self.G5_S040+self.G5_S050-self.G5_S060+self.G5_S070+self.G5_S080+self.G5_S090
      self.G6_S100 = self.G6_S040+self.G6_S050-self.G6_S060+self.G6_S070+self.G6_S080+self.G6_S090
      self.G7_S100 = self.G7_S040+self.G7_S050-self.G7_S060+self.G7_S070+self.G7_S080+self.G7_S090
      self.G8_S100 = self.G8_S040+self.G8_S050-self.G8_S060+self.G8_S070+self.G8_S080+self.G8_S090
      self.G9_S100 = self.G9_S040+self.G9_S050-self.G9_S060+self.G9_S070+self.G9_S080+self.G9_S090
      
      self.G3_S140 = self.G3_S110+self.G3_S120+self.G3_S130
      self.G4_S140 = self.G4_S110+self.G4_S120+self.G4_S130
      self.G5_S140 = self.G5_S110+self.G5_S120+self.G5_S130
      self.G6_S140 = self.G6_S110+self.G6_S120+self.G6_S130
      self.G7_S140 = self.G7_S110+self.G7_S120+self.G7_S130
      self.G8_S140 = self.G8_S110+self.G8_S120+self.G8_S130
      self.G9_S140 = self.G9_S110+self.G9_S120+self.G9_S130      
      
      self.G3_S150 = self.G3_S151+self.G3_S152+self.G3_S153+self.G3_S154+self.G3_S155+self.G3_S156+self.G3_S157+self.G3_S157+self.G3_S159
      self.G4_S150 = self.G4_S151+self.G4_S152+self.G4_S153+self.G4_S154+self.G4_S155+self.G4_S156+self.G4_S157+self.G4_S157+self.G4_S159
      self.G5_S150 = self.G5_S151+self.G5_S152+self.G5_S153+self.G5_S154+self.G5_S155+self.G5_S156+self.G5_S157+self.G5_S157+self.G5_S159
      self.G6_S150 = self.G6_S151+self.G6_S152+self.G6_S153+self.G6_S154+self.G6_S155+self.G6_S156+self.G6_S157+self.G6_S157+self.G6_S159
      self.G7_S150 = self.G7_S151+self.G7_S152+self.G7_S153+self.G7_S154+self.G7_S155+self.G7_S156+self.G7_S157+self.G7_S157+self.G7_S159
      self.G8_S150 = self.G8_S151+self.G8_S152+self.G8_S153+self.G8_S154+self.G8_S155+self.G8_S156+self.G8_S157+self.G8_S157+self.G8_S159
      self.G9_S150 = self.G9_S151+self.G9_S152+self.G9_S153+self.G9_S154+self.G9_S155+self.G9_S156+self.G9_S157+self.G9_S157+self.G9_S159
      
      self.G3_S160 = self.G3_S161+self.G3_S162+self.G3_S163+self.G3_S164+self.G3_S165+self.G3_S166+self.G3_S167+self.G3_S167+self.G3_S169
      self.G4_S160 = self.G4_S161+self.G4_S162+self.G4_S163+self.G4_S164+self.G4_S165+self.G4_S166+self.G4_S167+self.G4_S167+self.G4_S169
      self.G5_S160 = self.G5_S161+self.G5_S162+self.G5_S163+self.G5_S164+self.G5_S165+self.G5_S166+self.G5_S167+self.G5_S167+self.G5_S169
      self.G6_S160 = self.G6_S161+self.G6_S162+self.G6_S163+self.G6_S164+self.G6_S165+self.G6_S166+self.G6_S167+self.G6_S167+self.G6_S169
      self.G7_S160 = self.G7_S161+self.G7_S162+self.G7_S163+self.G7_S164+self.G7_S165+self.G7_S166+self.G7_S167+self.G7_S167+self.G7_S169
      self.G8_S160 = self.G8_S161+self.G8_S162+self.G8_S163+self.G8_S164+self.G8_S165+self.G8_S166+self.G8_S167+self.G8_S167+self.G8_S169
      self.G9_S160 = self.G9_S161+self.G9_S162+self.G9_S163+self.G9_S164+self.G9_S165+self.G9_S166+self.G9_S167+self.G9_S167+self.G9_S169
      
      self.G3_S200 = self.G3_S140+self.G3_S150-self.G3_S160+self.G3_S170+self.G3_S180+self.G3_S190
      self.G4_S200 = self.G4_S140+self.G4_S150-self.G4_S160+self.G4_S170+self.G4_S180+self.G4_S190
      self.G5_S200 = self.G5_S140+self.G5_S150-self.G5_S160+self.G5_S170+self.G5_S180+self.G5_S190
      self.G6_S200 = self.G6_S140+self.G6_S150-self.G6_S160+self.G6_S170+self.G6_S180+self.G6_S190
      self.G7_S200 = self.G7_S140+self.G7_S150-self.G7_S160+self.G7_S170+self.G7_S180+self.G7_S190
      self.G8_S200 = self.G8_S140+self.G8_S150-self.G8_S160+self.G8_S170+self.G8_S180+self.G8_S190
      self.G9_S200 = self.G9_S140+self.G9_S150-self.G9_S160+self.G9_S170+self.G9_S180+self.G9_S190      
    
      self.G10_S010 = self.G3_S010+self.G4_S010+self.G5_S010+self.G6_S010+self.G7_S010+self.G8_S010+self.G9_S010 
      self.G10_S020 = self.G3_S020+self.G4_S020+self.G5_S020+self.G6_S020+self.G7_S020+self.G8_S020+self.G9_S020 
      self.G10_S030 = self.G3_S030+self.G4_S030+self.G5_S030+self.G6_S030+self.G7_S030+self.G8_S030+self.G9_S030 
      self.G10_S040 = self.G3_S040+self.G4_S040+self.G5_S040+self.G6_S040+self.G7_S040+self.G8_S040+self.G9_S040 
      self.G10_S050 = self.G3_S050+self.G4_S050+self.G5_S050+self.G6_S050+self.G7_S050+self.G8_S050+self.G9_S050 
      self.G10_S051 = self.G3_S051+self.G4_S051+self.G5_S051+self.G6_S051+self.G7_S051+self.G8_S051+self.G9_S051 
      self.G10_S052 = self.G3_S052+self.G4_S052+self.G5_S052+self.G6_S052+self.G7_S052+self.G8_S052+self.G9_S052 
      self.G10_S053 = self.G3_S053+self.G4_S053+self.G5_S053+self.G6_S053+self.G7_S053+self.G8_S053+self.G9_S053 
      self.G10_S054 = self.G3_S054+self.G4_S054+self.G5_S054+self.G6_S054+self.G7_S054+self.G8_S054+self.G9_S054 
      self.G10_S055 = self.G3_S055+self.G4_S055+self.G5_S055+self.G6_S055+self.G7_S055+self.G8_S055+self.G9_S055 
      self.G10_S056 = self.G3_S056+self.G4_S056+self.G5_S056+self.G6_S056+self.G7_S056+self.G8_S056+self.G9_S056 
      self.G10_S057 = self.G3_S057+self.G4_S057+self.G5_S057+self.G6_S057+self.G7_S057+self.G8_S057+self.G9_S057 
      self.G10_S058 = self.G3_S058+self.G4_S058+self.G5_S058+self.G6_S058+self.G7_S058+self.G8_S058+self.G9_S058 
      self.G10_S059 = self.G3_S059+self.G4_S059+self.G5_S059+self.G6_S059+self.G7_S059+self.G8_S059+self.G9_S059 
      self.G10_S060 = self.G3_S060+self.G4_S060+self.G5_S060+self.G6_S060+self.G7_S060+self.G8_S060+self.G9_S060 
      self.G10_S061 = self.G3_S061+self.G4_S061+self.G5_S061+self.G6_S061+self.G7_S061+self.G8_S061+self.G9_S061 
      self.G10_S062 = self.G3_S062+self.G4_S062+self.G5_S062+self.G6_S062+self.G7_S062+self.G8_S062+self.G9_S062 
      self.G10_S063 = self.G3_S063+self.G4_S063+self.G5_S063+self.G6_S063+self.G7_S063+self.G8_S063+self.G9_S063 
      self.G10_S064 = self.G3_S064+self.G4_S064+self.G5_S064+self.G6_S064+self.G7_S064+self.G8_S064+self.G9_S064 
      self.G10_S065 = self.G3_S065+self.G4_S065+self.G5_S065+self.G6_S065+self.G7_S065+self.G8_S065+self.G9_S065 
      self.G10_S066 = self.G3_S066+self.G4_S066+self.G5_S066+self.G6_S066+self.G7_S066+self.G8_S066+self.G9_S066 
      self.G10_S067 = self.G3_S067+self.G4_S067+self.G5_S067+self.G6_S067+self.G7_S067+self.G8_S067+self.G9_S067 
      self.G10_S068 = self.G3_S068+self.G4_S068+self.G5_S068+self.G6_S068+self.G7_S068+self.G8_S068+self.G9_S068 
      self.G10_S069 = self.G3_S069+self.G4_S069+self.G5_S069+self.G6_S069+self.G7_S069+self.G8_S069+self.G9_S069 
      self.G10_S070 = self.G3_S070+self.G4_S070+self.G5_S070+self.G6_S070+self.G7_S070+self.G8_S070+self.G9_S070 
      self.G10_S080 = self.G3_S080+self.G4_S080+self.G5_S080+self.G6_S080+self.G7_S080+self.G8_S080+self.G9_S080 
      self.G10_S090 = self.G3_S090+self.G4_S090+self.G5_S090+self.G6_S090+self.G7_S090+self.G8_S090+self.G9_S090 
      self.G10_S100 = self.G3_S100+self.G4_S100+self.G5_S100+self.G6_S100+self.G7_S100+self.G8_S100+self.G9_S100 
      self.G10_S110 = self.G3_S110+self.G4_S110+self.G5_S110+self.G6_S110+self.G7_S110+self.G8_S110+self.G9_S110 
      self.G10_S120 = self.G3_S120+self.G4_S120+self.G5_S120+self.G6_S120+self.G7_S120+self.G8_S120+self.G9_S120 
      self.G10_S130 = self.G3_S130+self.G4_S130+self.G5_S130+self.G6_S130+self.G7_S130+self.G8_S130+self.G9_S130 
      self.G10_S140 = self.G3_S140+self.G4_S140+self.G5_S140+self.G6_S140+self.G7_S140+self.G8_S140+self.G9_S140 
      self.G10_S150 = self.G3_S150+self.G4_S150+self.G5_S150+self.G6_S150+self.G7_S150+self.G8_S150+self.G9_S150 
      self.G10_S151 = self.G3_S151+self.G4_S151+self.G5_S151+self.G6_S151+self.G7_S151+self.G8_S151+self.G9_S151 
      self.G10_S152 = self.G3_S152+self.G4_S152+self.G5_S152+self.G6_S152+self.G7_S152+self.G8_S152+self.G9_S152 
      self.G10_S153 = self.G3_S153+self.G4_S153+self.G5_S153+self.G6_S153+self.G7_S153+self.G8_S153+self.G9_S153 
      self.G10_S154 = self.G3_S154+self.G4_S154+self.G5_S154+self.G6_S154+self.G7_S154+self.G8_S154+self.G9_S154 
      self.G10_S155 = self.G3_S155+self.G4_S155+self.G5_S155+self.G6_S155+self.G7_S155+self.G8_S155+self.G9_S155 
      self.G10_S156 = self.G3_S156+self.G4_S156+self.G5_S156+self.G6_S156+self.G7_S156+self.G8_S156+self.G9_S156 
      self.G10_S157 = self.G3_S157+self.G4_S157+self.G5_S157+self.G6_S157+self.G7_S157+self.G8_S157+self.G9_S157 
      self.G10_S158 = self.G3_S158+self.G4_S158+self.G5_S158+self.G6_S158+self.G7_S158+self.G8_S158+self.G9_S158 
      self.G10_S159 = self.G3_S159+self.G4_S159+self.G5_S159+self.G6_S159+self.G7_S159+self.G8_S159+self.G9_S159 
      self.G10_S160 = self.G3_S160+self.G4_S160+self.G5_S160+self.G6_S160+self.G7_S160+self.G8_S160+self.G9_S160 
      self.G10_S161 = self.G3_S161+self.G4_S161+self.G5_S161+self.G6_S161+self.G7_S161+self.G8_S161+self.G9_S161 
      self.G10_S162 = self.G3_S162+self.G4_S162+self.G5_S162+self.G6_S162+self.G7_S162+self.G8_S162+self.G9_S162 
      self.G10_S163 = self.G3_S163+self.G4_S163+self.G5_S163+self.G6_S163+self.G7_S163+self.G8_S163+self.G9_S163 
      self.G10_S164 = self.G3_S164+self.G4_S164+self.G5_S164+self.G6_S164+self.G7_S164+self.G8_S164+self.G9_S164 
      self.G10_S165 = self.G3_S165+self.G4_S165+self.G5_S165+self.G6_S165+self.G7_S165+self.G8_S165+self.G9_S165 
      self.G10_S166 = self.G3_S166+self.G4_S166+self.G5_S166+self.G6_S166+self.G7_S166+self.G8_S166+self.G9_S166 
      self.G10_S167 = self.G3_S167+self.G4_S167+self.G5_S167+self.G6_S167+self.G7_S167+self.G8_S167+self.G9_S167 
      self.G10_S168 = self.G3_S168+self.G4_S168+self.G5_S168+self.G6_S168+self.G7_S168+self.G8_S168+self.G9_S168 
      self.G10_S169 = self.G3_S169+self.G4_S169+self.G5_S169+self.G6_S169+self.G7_S169+self.G8_S169+self.G9_S169 
      self.G10_S170 = self.G3_S170+self.G4_S170+self.G5_S170+self.G6_S170+self.G7_S170+self.G8_S170+self.G9_S170 
      self.G10_S180 = self.G3_S180+self.G4_S180+self.G5_S180+self.G6_S180+self.G7_S180+self.G8_S180+self.G9_S180 
      self.G10_S190 = self.G3_S190+self.G4_S190+self.G5_S190+self.G6_S190+self.G7_S190+self.G8_S190+self.G9_S190 
      self.G10_S200 = self.G3_S200+self.G4_S200+self.G5_S200+self.G6_S200+self.G7_S200+self.G8_S200+self.G9_S200
  end
end