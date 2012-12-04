class AccountsController < ApplicationController
  before_filter :authenticate_user!, except: [:advantages]

  def my_access_code

  end

  def advantages

  end

  def join
    @session = current_user.sessions.last
    if @session && @session.ot_session_id
      @session_id = @session.ot_session_id
    else
      @session_id = "2_MX4yMTg0MjQ1Mn5-VHVlIERlYyAwNCAxMjowMzo0MyBQU1QgMjAxMn4wLjcxNjA3NDc2fg"
    end
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

  def change_email
    @user = current_user

    if params[:delete]
      params[:emails].each do |email_id|
        EmailAddress.find(email_id).destroy
      end
    elsif params[:primary]
      email_id = params[:emails].first
      email = EmailAddress.find(email_id)
      @user.email_addresses.each {|e| e.update_attributes(primary: false)}
      email.update_attributes(primary: true)
      @user.update_attributes(email: email.email)
    end

    redirect_to action: 'my_access_code'
  end

  def add_email
    @user = current_user
    @user.email_addresses.create(email: params[:email]) unless params[:email].blank?

    redirect_to action: 'my_access_code'
  end
end
