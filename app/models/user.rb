class User < ActiveRecord::Base
  before_validation(:on => :create) do
    self.dogovor_begin   =Date.today.to_date
    self.dogovor_end     =Date.today.to_date+1.year
    unless self.admin
      self.activation_begin=Date.today.to_date
      self.activation_end  =Date.today.to_date+7.days  
    end
  end

  has_many :enterprises, :dependent => :destroy
    
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :last_sign_in_at,
                  :admin, :contact_info, :dogovor_nomer, :dogovor_begin, :dogovor_end, :activation_begin, :activation_end, :activation_allowed
    
  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  attr_accessible :login  
  
  def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions).first
      end
    end

### This is the correct method you override with the code above
### def self.find_for_database_authentication(warden_conditions)
### end  

  # Валидация из гема validates_timeliness
  validates_date :dogovor_begin, :before => :dogovor_end
  validates_date :dogovor_end,   :after  => :dogovor_begin
  validates_date :activation_begin, :before => :activation_end
  validates_date :activation_end,   :after  => :activation_begin  
  
  self.per_page = 12 # число страниц для гема пагинации ...
  
  # Процент оставшихся дней в интервале активности ...
  def get_balanse
      unless self.activation_begin.nil? and self.activation_end.nil?
        return 100-(((Date.today.to_date.mjd-self.activation_begin.to_date.mjd).to_f/(self.activation_end.to_date.mjd-self.activation_begin.to_date.mjd))*100)
      else
        return 0
      end 
  end
  # Проверка активности учётной записи ...
  def is_active
    if ((self.activation_begin.to_date..self.activation_end.to_date) === Date.today.to_date)
      self.activation_allowed
    else
      false     
    end
  end  
end
