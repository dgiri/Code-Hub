class Users::SessionsController < Devise::SessionsController
  before_filter :all_users_list
  # layout "blank"
end