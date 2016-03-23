class User < ActiveRecord::Base
  has_secure_password
  validates :email, uniqueness: true, presence: true
  validates :password_confirmation, presence: true

  def friends
    User
        .joins('join friendships on friendships.friend_id = users.id')
        .where('friendships.my_id = ?', self.id)
        .select('users.*, friendships.is_blocked')
  end

  def strangers
    User.where.not(id: (friends.ids << self.id))
  end
end
