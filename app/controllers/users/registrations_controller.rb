class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :all_users_list
  # layout "blank"
end