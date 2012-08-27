# encoding: utf-8
# RailsAdmin config file. Generated on August 25, 2012 17:12
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|

  # If your default_local is different from :en, uncomment the following 2 lines and set your default locale here:
  require 'i18n'
  I18n.default_locale = :ru

  config.current_user_method { current_user } # auto-generated
  
  # If you want to track changes on your models:
  # config.audit_with :history, User

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, User

  # Set the admin name here (optional second array element will appear in a beautiful RailsAdmin red ©)
  config.main_app_name = ['Онлайн Финансовый Анализ', 'Администратор']
  # or for a dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }
  
  config.authorize_with do
    redirect_to root_path unless current_user.try(:admin?)
  end 
  
  #  ==> Global show view settings
  # Display empty fields in show views
  # config.compact_show_view = false

  #  ==> Global list view settings
  # Number of default rows per-page:
  # config.default_items_per_page = 20

  #  ==> Included models
  # Add all excluded models here:
  # config.excluded_models = [AnalyticalBalance, BalanseRow, BalanseValue, Enterprise, FormFourReport, FormOneReport, FormThreeReport, FormTwoReport, User]

  # Add models here if you want to go 'whitelist mode':
  # config.included_models = [AnalyticalBalance, BalanseRow, BalanseValue, Enterprise, FormFourReport, FormOneReport, FormThreeReport, FormTwoReport, User]

  # Application wide tried label methods for models' instances
  # config.label_methods << :description # Default is [:name, :title]

  #  ==> Global models configuration
  # config.models do
  #   # Configuration here will affect all included models in all scopes, handle with care!
  #
  #   list do
  #     # Configuration here will affect all included models in list sections (same for show, export, edit, update, create)
  #
  #     fields_of_type :date do
  #       # Configuration here will affect all date fields, in the list section, for all included models. See README for a comprehensive type list.
  #     end
  #   end
  # end
  #
  #  ==> Model specific configuration
  # Keep in mind that *all* configuration blocks are optional.
  # RailsAdmin will try his best to provide the best defaults for each section, for each field.
  # Try to override as few things as possible, in the most generic way. Try to avoid setting labels for models and attributes, use ActiveRecord I18n API instead.
  # Less code is better code!
  # config.model MyModel do
  #   # Cross-section field configuration
  #   object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #   label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #   label_plural 'My models'      # Same, plural
  #   weight -1                     # Navigation priority. Bigger is higher.
  #   parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #   navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  #   # Section specific configuration:
  #   list do
  #     filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #     items_per_page 100    # Override default_items_per_page
  #     sort_by :id           # Sort column (default is primary key)
  #     sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     # Here goes the fields configuration for the list view
  #   end
  # end

  # Your model's configuration, to help you get started:

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible. (visible(true))

  # config.model AnalyticalBalance do
  #   # Found associations:
  #     configure :enterprise, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :enterprise_id, :integer         # Hidden 
  #     configure :date_period_beg, :date 
  #     configure :date_period_end, :date 
  #     configure :row_type, :integer 
  #     configure :G1, :string 
  #     configure :G2, :string 
  #     configure :G3, :integer 
  #     configure :G4, :decimal 
  #     configure :G5, :integer 
  #     configure :G6, :decimal 
  #     configure :G7, :integer 
  #     configure :G8, :decimal 
  #     configure :G9, :decimal 
  #     configure :G10, :decimal 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model BalanseRow do
  #   # Found associations:
  #     configure :enterprise, :belongs_to_association 
  #     configure :balanse_values, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :enterprise_id, :integer         # Hidden 
  #     configure :diag_type, :integer 
  #     configure :date_period_beg, :date 
  #     configure :date_period_end, :date 
  #     configure :name, :string 
  #     configure :summa, :integer 
  #     configure :summa_dec, :decimal 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model BalanseValue do
  #   # Found associations:
  #     configure :balanse_row, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :balanse_row_id, :integer         # Hidden 
  #     configure :date_period, :date 
  #     configure :summa, :integer 
  #     configure :summa_dec, :decimal 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Enterprise do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :form_one_reports, :has_many_association 
  #     configure :form_two_reports, :has_many_association 
  #     configure :form_three_reports, :has_many_association 
  #     configure :form_four_reports, :has_many_association 
  #     configure :analytical_balances, :has_many_association 
  #     configure :balanse_rows, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :parent_id, :integer 
  #     configure :user_id, :integer         # Hidden 
  #     configure :org_name, :string 
  #     configure :uch_nomer_plat, :string 
  #     configure :vid_econom_deyatel, :string 
  #     configure :organiz_pravo_form, :string 
  #     configure :organ_upravlen, :string 
  #     configure :edinic_izmer, :string 
  #     configure :adres, :string 
  #     configure :K1, :decimal 
  #     configure :K2, :decimal 
  #     configure :K3, :decimal 
  #     configure :rab_date_beg, :date 
  #     configure :rab_date_end, :date 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model FormFourReport do
  #   # Found associations:
  #     configure :enterprise, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :enterprise_id, :integer         # Hidden 
  #     configure :date_period_beg, :date 
  #     configure :date_period_end, :date 
  #     configure :S020, :integer 
  #     configure :S021, :integer 
  #     configure :S022, :integer 
  #     configure :S023, :integer 
  #     configure :S024, :integer 
  #     configure :S030, :integer 
  #     configure :S031, :integer 
  #     configure :S032, :integer 
  #     configure :S033, :integer 
  #     configure :S034, :integer 
  #     configure :S040, :integer 
  #     configure :S050, :integer 
  #     configure :S051, :integer 
  #     configure :S052, :integer 
  #     configure :S053, :integer 
  #     configure :S054, :integer 
  #     configure :S055, :integer 
  #     configure :S060, :integer 
  #     configure :S061, :integer 
  #     configure :S062, :integer 
  #     configure :S063, :integer 
  #     configure :S064, :integer 
  #     configure :S070, :integer 
  #     configure :S080, :integer 
  #     configure :S081, :integer 
  #     configure :S082, :integer 
  #     configure :S083, :integer 
  #     configure :S084, :integer 
  #     configure :S090, :integer 
  #     configure :S091, :integer 
  #     configure :S092, :integer 
  #     configure :S093, :integer 
  #     configure :S094, :integer 
  #     configure :S095, :integer 
  #     configure :S100, :integer 
  #     configure :S110, :integer 
  #     configure :S120, :integer 
  #     configure :S130, :integer 
  #     configure :S140, :integer 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model FormOneReport do
  #   # Found associations:
  #     configure :enterprise, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :enterprise_id, :integer         # Hidden 
  #     configure :date_period, :date 
  #     configure :S110, :integer 
  #     configure :S120, :integer 
  #     configure :S130, :integer 
  #     configure :S131, :integer 
  #     configure :S132, :integer 
  #     configure :S133, :integer 
  #     configure :S140, :integer 
  #     configure :S150, :integer 
  #     configure :S160, :integer 
  #     configure :S170, :integer 
  #     configure :S180, :integer 
  #     configure :S190, :integer 
  #     configure :S210, :integer 
  #     configure :S211, :integer 
  #     configure :S212, :integer 
  #     configure :S213, :integer 
  #     configure :S214, :integer 
  #     configure :S215, :integer 
  #     configure :S216, :integer 
  #     configure :S220, :integer 
  #     configure :S230, :integer 
  #     configure :S240, :integer 
  #     configure :S250, :integer 
  #     configure :S260, :integer 
  #     configure :S270, :integer 
  #     configure :S280, :integer 
  #     configure :S290, :integer 
  #     configure :S300, :integer 
  #     configure :S410, :integer 
  #     configure :S420, :integer 
  #     configure :S430, :integer 
  #     configure :S440, :integer 
  #     configure :S450, :integer 
  #     configure :S460, :integer 
  #     configure :S470, :integer 
  #     configure :S480, :integer 
  #     configure :S490, :integer 
  #     configure :S510, :integer 
  #     configure :S520, :integer 
  #     configure :S530, :integer 
  #     configure :S540, :integer 
  #     configure :S550, :integer 
  #     configure :S560, :integer 
  #     configure :S590, :integer 
  #     configure :S610, :integer 
  #     configure :S620, :integer 
  #     configure :S630, :integer 
  #     configure :S631, :integer 
  #     configure :S632, :integer 
  #     configure :S633, :integer 
  #     configure :S634, :integer 
  #     configure :S635, :integer 
  #     configure :S636, :integer 
  #     configure :S637, :integer 
  #     configure :S638, :integer 
  #     configure :S640, :integer 
  #     configure :S650, :integer 
  #     configure :S660, :integer 
  #     configure :S670, :integer 
  #     configure :S690, :integer 
  #     configure :S700, :integer 
  #     configure :Kfnez, :decimal 
  #     configure :Kfzav, :decimal 
  #     configure :Kdfnez, :decimal 
  #     configure :Kcap, :decimal 
  #     configure :Kman, :decimal 
  #     configure :K1, :decimal 
  #     configure :Kabsl, :decimal 
  #     configure :Kkrl, :decimal 
  #     configure :K2, :decimal 
  #     configure :K3, :decimal 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model FormThreeReport do
  #   # Found associations:
  #     configure :enterprise, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :enterprise_id, :integer         # Hidden 
  #     configure :date_period_beg, :date 
  #     configure :date_period_end, :date 
  #     configure :G3_S010, :integer 
  #     configure :G4_S010, :integer 
  #     configure :G5_S010, :integer 
  #     configure :G6_S010, :integer 
  #     configure :G7_S010, :integer 
  #     configure :G8_S010, :integer 
  #     configure :G9_S010, :integer 
  #     configure :G10_S010, :integer 
  #     configure :G3_S020, :integer 
  #     configure :G4_S020, :integer 
  #     configure :G5_S020, :integer 
  #     configure :G6_S020, :integer 
  #     configure :G7_S020, :integer 
  #     configure :G8_S020, :integer 
  #     configure :G9_S020, :integer 
  #     configure :G10_S020, :integer 
  #     configure :G3_S030, :integer 
  #     configure :G4_S030, :integer 
  #     configure :G5_S030, :integer 
  #     configure :G6_S030, :integer 
  #     configure :G7_S030, :integer 
  #     configure :G8_S030, :integer 
  #     configure :G9_S030, :integer 
  #     configure :G10_S030, :integer 
  #     configure :G3_S040, :integer 
  #     configure :G4_S040, :integer 
  #     configure :G5_S040, :integer 
  #     configure :G6_S040, :integer 
  #     configure :G7_S040, :integer 
  #     configure :G8_S040, :integer 
  #     configure :G9_S040, :integer 
  #     configure :G10_S040, :integer 
  #     configure :G3_S050, :integer 
  #     configure :G4_S050, :integer 
  #     configure :G5_S050, :integer 
  #     configure :G6_S050, :integer 
  #     configure :G7_S050, :integer 
  #     configure :G8_S050, :integer 
  #     configure :G9_S050, :integer 
  #     configure :G10_S050, :integer 
  #     configure :G3_S051, :integer 
  #     configure :G4_S051, :integer 
  #     configure :G5_S051, :integer 
  #     configure :G6_S051, :integer 
  #     configure :G7_S051, :integer 
  #     configure :G8_S051, :integer 
  #     configure :G9_S051, :integer 
  #     configure :G10_S051, :integer 
  #     configure :G3_S052, :integer 
  #     configure :G4_S052, :integer 
  #     configure :G5_S052, :integer 
  #     configure :G6_S052, :integer 
  #     configure :G7_S052, :integer 
  #     configure :G8_S052, :integer 
  #     configure :G9_S052, :integer 
  #     configure :G10_S052, :integer 
  #     configure :G3_S053, :integer 
  #     configure :G4_S053, :integer 
  #     configure :G5_S053, :integer 
  #     configure :G6_S053, :integer 
  #     configure :G7_S053, :integer 
  #     configure :G8_S053, :integer 
  #     configure :G9_S053, :integer 
  #     configure :G10_S053, :integer 
  #     configure :G3_S054, :integer 
  #     configure :G4_S054, :integer 
  #     configure :G5_S054, :integer 
  #     configure :G6_S054, :integer 
  #     configure :G7_S054, :integer 
  #     configure :G8_S054, :integer 
  #     configure :G9_S054, :integer 
  #     configure :G10_S054, :integer 
  #     configure :G3_S055, :integer 
  #     configure :G4_S055, :integer 
  #     configure :G5_S055, :integer 
  #     configure :G6_S055, :integer 
  #     configure :G7_S055, :integer 
  #     configure :G8_S055, :integer 
  #     configure :G9_S055, :integer 
  #     configure :G10_S055, :integer 
  #     configure :G3_S056, :integer 
  #     configure :G4_S056, :integer 
  #     configure :G5_S056, :integer 
  #     configure :G6_S056, :integer 
  #     configure :G7_S056, :integer 
  #     configure :G8_S056, :integer 
  #     configure :G9_S056, :integer 
  #     configure :G10_S056, :integer 
  #     configure :G3_S057, :integer 
  #     configure :G4_S057, :integer 
  #     configure :G5_S057, :integer 
  #     configure :G6_S057, :integer 
  #     configure :G7_S057, :integer 
  #     configure :G8_S057, :integer 
  #     configure :G9_S057, :integer 
  #     configure :G10_S057, :integer 
  #     configure :G3_S058, :integer 
  #     configure :G4_S058, :integer 
  #     configure :G5_S058, :integer 
  #     configure :G6_S058, :integer 
  #     configure :G7_S058, :integer 
  #     configure :G8_S058, :integer 
  #     configure :G9_S058, :integer 
  #     configure :G10_S058, :integer 
  #     configure :G3_S059, :integer 
  #     configure :G4_S059, :integer 
  #     configure :G5_S059, :integer 
  #     configure :G6_S059, :integer 
  #     configure :G7_S059, :integer 
  #     configure :G8_S059, :integer 
  #     configure :G9_S059, :integer 
  #     configure :G10_S059, :integer 
  #     configure :G3_S060, :integer 
  #     configure :G4_S060, :integer 
  #     configure :G5_S060, :integer 
  #     configure :G6_S060, :integer 
  #     configure :G7_S060, :integer 
  #     configure :G8_S060, :integer 
  #     configure :G9_S060, :integer 
  #     configure :G10_S060, :integer 
  #     configure :G3_S061, :integer 
  #     configure :G4_S061, :integer 
  #     configure :G5_S061, :integer 
  #     configure :G6_S061, :integer 
  #     configure :G7_S061, :integer 
  #     configure :G8_S061, :integer 
  #     configure :G9_S061, :integer 
  #     configure :G10_S061, :integer 
  #     configure :G3_S062, :integer 
  #     configure :G4_S062, :integer 
  #     configure :G5_S062, :integer 
  #     configure :G6_S062, :integer 
  #     configure :G7_S062, :integer 
  #     configure :G8_S062, :integer 
  #     configure :G9_S062, :integer 
  #     configure :G10_S062, :integer 
  #     configure :G3_S063, :integer 
  #     configure :G4_S063, :integer 
  #     configure :G5_S063, :integer 
  #     configure :G6_S063, :integer 
  #     configure :G7_S063, :integer 
  #     configure :G8_S063, :integer 
  #     configure :G9_S063, :integer 
  #     configure :G10_S063, :integer 
  #     configure :G3_S064, :integer 
  #     configure :G4_S064, :integer 
  #     configure :G5_S064, :integer 
  #     configure :G6_S064, :integer 
  #     configure :G7_S064, :integer 
  #     configure :G8_S064, :integer 
  #     configure :G9_S064, :integer 
  #     configure :G10_S064, :integer 
  #     configure :G3_S065, :integer 
  #     configure :G4_S065, :integer 
  #     configure :G5_S065, :integer 
  #     configure :G6_S065, :integer 
  #     configure :G7_S065, :integer 
  #     configure :G8_S065, :integer 
  #     configure :G9_S065, :integer 
  #     configure :G10_S065, :integer 
  #     configure :G3_S066, :integer 
  #     configure :G4_S066, :integer 
  #     configure :G5_S066, :integer 
  #     configure :G6_S066, :integer 
  #     configure :G7_S066, :integer 
  #     configure :G8_S066, :integer 
  #     configure :G9_S066, :integer 
  #     configure :G10_S066, :integer 
  #     configure :G3_S067, :integer 
  #     configure :G4_S067, :integer 
  #     configure :G5_S067, :integer 
  #     configure :G6_S067, :integer 
  #     configure :G7_S067, :integer 
  #     configure :G8_S067, :integer 
  #     configure :G9_S067, :integer 
  #     configure :G10_S067, :integer 
  #     configure :G3_S068, :integer 
  #     configure :G4_S068, :integer 
  #     configure :G5_S068, :integer 
  #     configure :G6_S068, :integer 
  #     configure :G7_S068, :integer 
  #     configure :G8_S068, :integer 
  #     configure :G9_S068, :integer 
  #     configure :G10_S068, :integer 
  #     configure :G3_S069, :integer 
  #     configure :G4_S069, :integer 
  #     configure :G5_S069, :integer 
  #     configure :G6_S069, :integer 
  #     configure :G7_S069, :integer 
  #     configure :G8_S069, :integer 
  #     configure :G9_S069, :integer 
  #     configure :G10_S069, :integer 
  #     configure :G3_S070, :integer 
  #     configure :G4_S070, :integer 
  #     configure :G5_S070, :integer 
  #     configure :G6_S070, :integer 
  #     configure :G7_S070, :integer 
  #     configure :G8_S070, :integer 
  #     configure :G9_S070, :integer 
  #     configure :G10_S070, :integer 
  #     configure :G3_S080, :integer 
  #     configure :G4_S080, :integer 
  #     configure :G5_S080, :integer 
  #     configure :G6_S080, :integer 
  #     configure :G7_S080, :integer 
  #     configure :G8_S080, :integer 
  #     configure :G9_S080, :integer 
  #     configure :G10_S080, :integer 
  #     configure :G3_S090, :integer 
  #     configure :G4_S090, :integer 
  #     configure :G5_S090, :integer 
  #     configure :G6_S090, :integer 
  #     configure :G7_S090, :integer 
  #     configure :G8_S090, :integer 
  #     configure :G9_S090, :integer 
  #     configure :G10_S090, :integer 
  #     configure :G3_S100, :integer 
  #     configure :G4_S100, :integer 
  #     configure :G5_S100, :integer 
  #     configure :G6_S100, :integer 
  #     configure :G7_S100, :integer 
  #     configure :G8_S100, :integer 
  #     configure :G9_S100, :integer 
  #     configure :G10_S100, :integer 
  #     configure :G3_S110, :integer 
  #     configure :G4_S110, :integer 
  #     configure :G5_S110, :integer 
  #     configure :G6_S110, :integer 
  #     configure :G7_S110, :integer 
  #     configure :G8_S110, :integer 
  #     configure :G9_S110, :integer 
  #     configure :G10_S110, :integer 
  #     configure :G3_S120, :integer 
  #     configure :G4_S120, :integer 
  #     configure :G5_S120, :integer 
  #     configure :G6_S120, :integer 
  #     configure :G7_S120, :integer 
  #     configure :G8_S120, :integer 
  #     configure :G9_S120, :integer 
  #     configure :G10_S120, :integer 
  #     configure :G3_S130, :integer 
  #     configure :G4_S130, :integer 
  #     configure :G5_S130, :integer 
  #     configure :G6_S130, :integer 
  #     configure :G7_S130, :integer 
  #     configure :G8_S130, :integer 
  #     configure :G9_S130, :integer 
  #     configure :G10_S130, :integer 
  #     configure :G3_S140, :integer 
  #     configure :G4_S140, :integer 
  #     configure :G5_S140, :integer 
  #     configure :G6_S140, :integer 
  #     configure :G7_S140, :integer 
  #     configure :G8_S140, :integer 
  #     configure :G9_S140, :integer 
  #     configure :G10_S140, :integer 
  #     configure :G3_S150, :integer 
  #     configure :G4_S150, :integer 
  #     configure :G5_S150, :integer 
  #     configure :G6_S150, :integer 
  #     configure :G7_S150, :integer 
  #     configure :G8_S150, :integer 
  #     configure :G9_S150, :integer 
  #     configure :G10_S150, :integer 
  #     configure :G3_S151, :integer 
  #     configure :G4_S151, :integer 
  #     configure :G5_S151, :integer 
  #     configure :G6_S151, :integer 
  #     configure :G7_S151, :integer 
  #     configure :G8_S151, :integer 
  #     configure :G9_S151, :integer 
  #     configure :G10_S151, :integer 
  #     configure :G3_S152, :integer 
  #     configure :G4_S152, :integer 
  #     configure :G5_S152, :integer 
  #     configure :G6_S152, :integer 
  #     configure :G7_S152, :integer 
  #     configure :G8_S152, :integer 
  #     configure :G9_S152, :integer 
  #     configure :G10_S152, :integer 
  #     configure :G3_S153, :integer 
  #     configure :G4_S153, :integer 
  #     configure :G5_S153, :integer 
  #     configure :G6_S153, :integer 
  #     configure :G7_S153, :integer 
  #     configure :G8_S153, :integer 
  #     configure :G9_S153, :integer 
  #     configure :G10_S153, :integer 
  #     configure :G3_S154, :integer 
  #     configure :G4_S154, :integer 
  #     configure :G5_S154, :integer 
  #     configure :G6_S154, :integer 
  #     configure :G7_S154, :integer 
  #     configure :G8_S154, :integer 
  #     configure :G9_S154, :integer 
  #     configure :G10_S154, :integer 
  #     configure :G3_S155, :integer 
  #     configure :G4_S155, :integer 
  #     configure :G5_S155, :integer 
  #     configure :G6_S155, :integer 
  #     configure :G7_S155, :integer 
  #     configure :G8_S155, :integer 
  #     configure :G9_S155, :integer 
  #     configure :G10_S155, :integer 
  #     configure :G3_S156, :integer 
  #     configure :G4_S156, :integer 
  #     configure :G5_S156, :integer 
  #     configure :G6_S156, :integer 
  #     configure :G7_S156, :integer 
  #     configure :G8_S156, :integer 
  #     configure :G9_S156, :integer 
  #     configure :G10_S156, :integer 
  #     configure :G3_S157, :integer 
  #     configure :G4_S157, :integer 
  #     configure :G5_S157, :integer 
  #     configure :G6_S157, :integer 
  #     configure :G7_S157, :integer 
  #     configure :G8_S157, :integer 
  #     configure :G9_S157, :integer 
  #     configure :G10_S157, :integer 
  #     configure :G3_S158, :integer 
  #     configure :G4_S158, :integer 
  #     configure :G5_S158, :integer 
  #     configure :G6_S158, :integer 
  #     configure :G7_S158, :integer 
  #     configure :G8_S158, :integer 
  #     configure :G9_S158, :integer 
  #     configure :G10_S158, :integer 
  #     configure :G3_S159, :integer 
  #     configure :G4_S159, :integer 
  #     configure :G5_S159, :integer 
  #     configure :G6_S159, :integer 
  #     configure :G7_S159, :integer 
  #     configure :G8_S159, :integer 
  #     configure :G9_S159, :integer 
  #     configure :G10_S159, :integer 
  #     configure :G3_S160, :integer 
  #     configure :G4_S160, :integer 
  #     configure :G5_S160, :integer 
  #     configure :G6_S160, :integer 
  #     configure :G7_S160, :integer 
  #     configure :G8_S160, :integer 
  #     configure :G9_S160, :integer 
  #     configure :G10_S160, :integer 
  #     configure :G3_S161, :integer 
  #     configure :G4_S161, :integer 
  #     configure :G5_S161, :integer 
  #     configure :G6_S161, :integer 
  #     configure :G7_S161, :integer 
  #     configure :G8_S161, :integer 
  #     configure :G9_S161, :integer 
  #     configure :G10_S161, :integer 
  #     configure :G3_S162, :integer 
  #     configure :G4_S162, :integer 
  #     configure :G5_S162, :integer 
  #     configure :G6_S162, :integer 
  #     configure :G7_S162, :integer 
  #     configure :G8_S162, :integer 
  #     configure :G9_S162, :integer 
  #     configure :G10_S162, :integer 
  #     configure :G3_S163, :integer 
  #     configure :G4_S163, :integer 
  #     configure :G5_S163, :integer 
  #     configure :G6_S163, :integer 
  #     configure :G7_S163, :integer 
  #     configure :G8_S163, :integer 
  #     configure :G9_S163, :integer 
  #     configure :G10_S163, :integer 
  #     configure :G3_S164, :integer 
  #     configure :G4_S164, :integer 
  #     configure :G5_S164, :integer 
  #     configure :G6_S164, :integer 
  #     configure :G7_S164, :integer 
  #     configure :G8_S164, :integer 
  #     configure :G9_S164, :integer 
  #     configure :G10_S164, :integer 
  #     configure :G3_S165, :integer 
  #     configure :G4_S165, :integer 
  #     configure :G5_S165, :integer 
  #     configure :G6_S165, :integer 
  #     configure :G7_S165, :integer 
  #     configure :G8_S165, :integer 
  #     configure :G9_S165, :integer 
  #     configure :G10_S165, :integer 
  #     configure :G3_S166, :integer 
  #     configure :G4_S166, :integer 
  #     configure :G5_S166, :integer 
  #     configure :G6_S166, :integer 
  #     configure :G7_S166, :integer 
  #     configure :G8_S166, :integer 
  #     configure :G9_S166, :integer 
  #     configure :G10_S166, :integer 
  #     configure :G3_S167, :integer 
  #     configure :G4_S167, :integer 
  #     configure :G5_S167, :integer 
  #     configure :G6_S167, :integer 
  #     configure :G7_S167, :integer 
  #     configure :G8_S167, :integer 
  #     configure :G9_S167, :integer 
  #     configure :G10_S167, :integer 
  #     configure :G3_S168, :integer 
  #     configure :G4_S168, :integer 
  #     configure :G5_S168, :integer 
  #     configure :G6_S168, :integer 
  #     configure :G7_S168, :integer 
  #     configure :G8_S168, :integer 
  #     configure :G9_S168, :integer 
  #     configure :G10_S168, :integer 
  #     configure :G3_S169, :integer 
  #     configure :G4_S169, :integer 
  #     configure :G5_S169, :integer 
  #     configure :G6_S169, :integer 
  #     configure :G7_S169, :integer 
  #     configure :G8_S169, :integer 
  #     configure :G9_S169, :integer 
  #     configure :G10_S169, :integer 
  #     configure :G3_S170, :integer 
  #     configure :G4_S170, :integer 
  #     configure :G5_S170, :integer 
  #     configure :G6_S170, :integer 
  #     configure :G7_S170, :integer 
  #     configure :G8_S170, :integer 
  #     configure :G9_S170, :integer 
  #     configure :G10_S170, :integer 
  #     configure :G3_S180, :integer 
  #     configure :G4_S180, :integer 
  #     configure :G5_S180, :integer 
  #     configure :G6_S180, :integer 
  #     configure :G7_S180, :integer 
  #     configure :G8_S180, :integer 
  #     configure :G9_S180, :integer 
  #     configure :G10_S180, :integer 
  #     configure :G3_S190, :integer 
  #     configure :G4_S190, :integer 
  #     configure :G5_S190, :integer 
  #     configure :G6_S190, :integer 
  #     configure :G7_S190, :integer 
  #     configure :G8_S190, :integer 
  #     configure :G9_S190, :integer 
  #     configure :G10_S190, :integer 
  #     configure :G3_S200, :integer 
  #     configure :G4_S200, :integer 
  #     configure :G5_S200, :integer 
  #     configure :G6_S200, :integer 
  #     configure :G7_S200, :integer 
  #     configure :G8_S200, :integer 
  #     configure :G9_S200, :integer 
  #     configure :G10_S200, :integer 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model FormTwoReport do
  #   # Found associations:
  #     configure :enterprise, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :enterprise_id, :integer         # Hidden 
  #     configure :date_period_beg, :date 
  #     configure :date_period_end, :date 
  #     configure :S010, :integer 
  #     configure :S020, :integer 
  #     configure :S030, :integer 
  #     configure :S040, :integer 
  #     configure :S050, :integer 
  #     configure :S060, :integer 
  #     configure :S070, :integer 
  #     configure :S080, :integer 
  #     configure :S090, :integer 
  #     configure :S100, :integer 
  #     configure :S101, :integer 
  #     configure :S102, :integer 
  #     configure :S103, :integer 
  #     configure :S104, :integer 
  #     configure :S110, :integer 
  #     configure :S111, :integer 
  #     configure :S112, :integer 
  #     configure :S120, :integer 
  #     configure :S121, :integer 
  #     configure :S122, :integer 
  #     configure :S130, :integer 
  #     configure :S131, :integer 
  #     configure :S132, :integer 
  #     configure :S133, :integer 
  #     configure :S140, :integer 
  #     configure :S150, :integer 
  #     configure :S160, :integer 
  #     configure :S170, :integer 
  #     configure :S180, :integer 
  #     configure :S190, :integer 
  #     configure :S200, :integer 
  #     configure :S210, :integer 
  #     configure :S211, :integer 
  #     configure :S212, :integer 
  #     configure :S213, :integer 
  #     configure :S214, :integer 
  #     configure :S220, :integer 
  #     configure :S230, :integer 
  #     configure :S240, :integer 
  #     configure :S250, :integer 
  #     configure :S260, :integer 
  #     configure :Kobk, :decimal 
  #     configure :Kobs, :decimal 
  #     configure :Kobzs, :decimal 
  #     configure :Kobgp, :decimal 
  #     configure :Kobdz, :decimal 
  #     configure :Kobkz, :decimal 
  #     configure :Krenprod, :decimal 
  #     configure :Krenact, :decimal 
  #     configure :Krensk, :decimal 
  #     configure :Krenpz, :decimal 
  #     configure :Krenps, :decimal 
  #     configure :Krenor, :decimal 
  #     configure :Krenchp, :decimal 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model User do
  #   # Found associations:
  #     configure :enterprises, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :email, :string 
  #     configure :password, :password         # Hidden 
  #     configure :password_confirmation, :password         # Hidden 
  #     configure :reset_password_token, :string         # Hidden 
  #     configure :reset_password_sent_at, :datetime 
  #     configure :remember_created_at, :datetime 
  #     configure :sign_in_count, :integer 
  #     configure :current_sign_in_at, :datetime 
  #     configure :last_sign_in_at, :datetime 
  #     configure :current_sign_in_ip, :string 
  #     configure :last_sign_in_ip, :string 
  #     configure :admin, :boolean 
  #     configure :username, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
end
