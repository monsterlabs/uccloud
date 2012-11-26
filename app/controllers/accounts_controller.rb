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
end
