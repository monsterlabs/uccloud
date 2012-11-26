class AccountsController < ApplicationController
  before_filter :authenticate_user!, except: [:advantages]

  def my_access_code

  end

  def advantages

  end

  def join

  end

  def faq

  end

  def change_access_code
    @user = current_user
    @user.user_access_code = params[:user][:user_access_code]
    @user.custom_access_code = true
    @user.save

    redirect_to action: 'my_access_code'
  end
end
