class PostsController < ApplicationController

  before_action :check_login
  
  def new
  end
  
  def create_comment
    as_type = params[:as_type].to_i
    content = params[:comment]
    post_id = params[:post_id]
  #先判断当前是否有用户登录，没有登录需要提示登录
    if @current_user.blank?
      flash.notice = "您还未登录，请先登录！"
      redirect_to "/posts/show_posts/#{post_id}"
  #再判断评论内容是否为空，内容为空，提示并且返回到帖子详情页面
    elsif content.blank?
      flash.notice = "评论内容不能为空"
      redirect_to "/posts/show_posts/#{post_id}"
    else
    #as_type参数为0时，说明是帖子的评论
      if as_type == 0
      #创建评论
        boolean_0 = Comment.create(status:0,account_id:@current_user.id,as_type:as_type,content:content,post_id:post_id)
        if boolean_0
          flash.notice = "评论成功"
        else
          flash.notice = "评论失败，请重新评论"
        end
      #重定向到帖子详情页面
        redirect_to "/posts/show_posts/#{post_id}"
    #as_type参数为1时，说明是评论下面的回复
      elsif as_type == 1
        comment_id = params[:comment_id]
        re_reply_id = params[:re_reply_id]
        boolean_1 = Comment.create(status:0,account_id:@current_user.id,as_type:as_type,content:content,post_id:post_id,re_comment_id:comment_id,re_reply_id:re_reply_id)
        if boolean_1
          flash.notice = "回复成功"
        else
          flash.notice = "回复失败，请重新回复"
        end
       redirect_to "/posts/show_posts/#{post_id}"
      end
    end
  end
  
  def show_posts
		post_id = params[:post_id]
		@post = Post.find(post_id)
		#as_type为0时代表帖子的评论，为1时代表评论的回复
		@comments = Comment.where(post_id:post_id,as_type:0).order(created_at: :desc).page(params[:page]).per(10)
  end

  def create
    head = params[:post][:head]
    body = params[:post][:body].strip
    if head.blank?
      flash.notice = "head canot be empty"
    elsif body.length < 8
      flash.notice = "body canot less 8 word"
    else
      post= Post.new(account_id: @current_user.id,as_type:0,status:0)
      post.head=head
      post.body=body
      boolean=post.save
      if boolean
        flash.notice = "publish success"
        redirect_to :root
      else
        flash.notice = "publish failed , please republish"
        render "/posts/new"
      end
    end
  end
  
  def create_thumb
    post_id = params[:post_id]
    is_thumb = params[:is_thumb]
    account_id = @current_user.id
    thumb = Thumb.find_or_create_by(account_id:account_id,post_id:post_id)
    if is_thumb == '0'
      thumb.is_thumb = false
    elsif is_thumb == '1'
      thumb.is_thumb = true
    end
    thumb.save
  end  
    
  
end
