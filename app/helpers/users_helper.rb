module UsersHelper
  def ban_status(user)
    if user.access_locked?
      'Unban'
    else
      'ban'
    end
  end
end
