require 'digest/md5'

class User < ActiveRecord::Base
  def self.validate(username, password)
    user = User.find_by(username: username)
    if (user != nil && user.password == Digest::MD5.hexdigest(password))
      return user
    else
      return nil
    end
  end

  def render_text
    "zjh#{self.thuid}:yhm=#{self.username}:xm=#{self.real_name}:yhlb=#{self.user_type}:dw=#{self.department}:email=#{self.email}"
  end
end