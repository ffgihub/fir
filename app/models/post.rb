class Post < ApplicationRecord

  def get_account_name
    account_id = self.account_id
    account = Account.find_by(id:account_id)
    name = "this user unname"
    if account
    name = account.name
    end
  end

  def get_updated_at
    updated_at = self.updated_at
    now = Time.now
    
    time_distance = (now - updated_at).to_i
    
    if time_distance < 60
      date = "#{time_distance}s before"
    
    elsif time_distance/60 <60
      date = "#{time_distance/60}m before"
    
    elsif time_distance/(60*60) < 24
      date = "#{time_distance/(60*60)}h before"
      
    elsif time_distance/(60*60*24) < 2
      date = "1 day before"
      
    else
      
      date = updated_at.strftime("%Y-%m-%d")
      
    end
    
    date
    
  end
  
  def get_post_items
    num = Comment.where(post_id:self.id).count
  end
  
  def get_thumbs
    num = Thumb.where(post_id:self.id,is_thumb:true).count
  end
  
  def get_thumb_info(account_id)
    thumb = Thumb.find_by(post_id:self.id,account_id:account_id)
    boolean = false
    if thumb && thumb.is_thumb
      boolean = true
    end
  end

end
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
      
      
      
      
      
      
      
      
      
      
      
      
      
      
