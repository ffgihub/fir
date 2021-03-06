class Comment < ApplicationRecord

  def get_account_name
    account = Account.find_by(id:self.account_id)
    if account
      name = account.name
    else
      name = 'user not signup'
    end
  end
  
  def get_created_at
	  created_at = self.created_at
	  now = Time.now
	
	  time_distance = (now - created_at).to_i
	  if time_distance == 0
		  date = 'now'
	  elsif time_distance <60
		  date ="#{time_distance}s before"
	  elsif time_distance/60 <60
	  	date ="#{time_distance/60}m before"
	  elsif time_distance/(60*60) <24
		  date ="#{time_distance/(60*60)}h before"
	  else
	  	date = created_at.strftime("%Y-%m-%d %H:%M")
	  end
	  date
  end
  
  def get_account_right(current_user)
	if current_user.blank?
		boolean = false
	elsif current_user.role > 0
		boolean = true
	elsif current_user.id == self.account_id
		boolean = true
	else	
		boolean = false
	end
	boolean

  end

end
