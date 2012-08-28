class User < ActiveRecord::Base
  
  has_many :enterprises, :dependent => :destroy
    
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :last_sign_in_at,
                  :admin, :username, :contact_info, :dogovor_nomer, :dogovor_begin, :dogovor_end, :last_pay_date, :last_active_date, :curent_status
    
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
    
  
  self.per_page = 12 # число страниц для гема пагинации ...
end
