class AccountsController < ApplicationController

  before_action :check_login, except:[:signup,:create_account,:login,:create_login,:logout]
  
  def login
  end

  def logout
    #session[:account_id] = nil
    cookies.delete(:auth_token)
    redirect_to :root
  end
  
  def account_active
    @accounts = Account.where(role:1)
  end
  
  def update_active
    account_id = params[:account_id]
    account = Account.find(account_id)
    account.status=0
    account.save
    redirect_to :account_active
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
        
        subject = "#{name} hello ,welcome join CSDN"
        html = "#{name} hello, you signup success,now you can login CSDN"
        response = SendMail.send_mail(email,subject,html)
        puts "===print signup information\n===#{response}"
        
      else
        flash.notice = "signup fail ! please re signup"
        render :signup
      end
    end
  end
  
  def create_login
    email = params[:email].strip
    password_html = params[:password].strip
    
    account = Account.find_by(email:email)
    
    if account
      if account.role == 1 && account.status == 0
        if Des.des_decode(account.password).to_s == password_html
          
          #session[:account_id] = account.id
          if params[:remember_me]
            cookies.permanent[:auth_token] = account.auth_token
          else
            cookies[:auth_token] = account.auth_token
          end
          
          flash.notice = "login success !"
          redirect_to :root
        else
          flash.notice = "username password mistake !"
          render :login
        end
      elsif account.role == 1 && account.status == 1
        flash.notice = "your user not activity ,please contect administrator "
        render :login
      else
        if Des.des_decode(account.password).to_s == password_html
          
          #session[:account_id] = account.id
          if params[:remember_me]
            cookies.permanent[:auth_token] = account.auth_token
          else
            cookies[:auth_token] = account.auth_token
          end
                    
          flash.notice = "login success !"
          redirect_to :root
        else
          flash.notice = "username password mistake !"
          render :login
        end
      end
    else
      flash.notice = "user not signup please signup"
      render :login
    end
  end
  
     

end
