class ApplicationController < ActionController::Base
  # ref: https://api.rubyonrails.org/classes/ActionController/RequestForgeryProtection/ClassMethods.html#method-i-skip_forgery_protection
  skip_before_action :verify_authenticity_token
end