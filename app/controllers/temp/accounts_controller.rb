class AccountsController < ApplicationController
  def login
  end

  def signup
    @account=Account.new
  end

  def create_account
    name = params[:account][:name]
    email = params[:account][:email]
    password = params[:account][:password]
    password_confirmation = params[:account][:password_confirmation]
    role = params[:account][:role]
    
    status = 0
    if role.to_i == 1
      status = 1
    end
    
    account = Account.find_by(email:email)
    @account = Account.new
    
    if name.blank? || email.blank?
      flash.notice = "username or email is empty"
      render :signup
      
    elsif account
      flash.notice = "email is regited"
      render :signup
      
    elsif name.length > 5
      flash.notice = "username length above 5"
      render :signup
      
    elsif password != password_confirmation
      flash.notice = "twice input password different"
      render :signup
      
    else
      @account.status = status
      @account.name = name
      @account.email = email
      @account.password = Des.des_encode(password)
      @account.role = role
      
      boolean = @account.save
      
      if boolean
        flash.notice = "signup success ! please ligin"
        redirect_to :login
      else
        flash.notice = "signup fail ! please re signup"
        render :signup
      end
    end
  end
     

end
