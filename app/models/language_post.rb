class LanguagePost < ActiveRecord::Base
  belongs_to :post
  belongs_to :language  
end
