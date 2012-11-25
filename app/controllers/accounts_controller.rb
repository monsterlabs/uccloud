class AccountsController < ApplicationController
  before_filter :authenticate_user!
  
  def my_access_code

  end
end
