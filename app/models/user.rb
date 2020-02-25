# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  comments_count  :integer
#  email           :string
#  is_private      :boolean
#  likes_count     :integer
#  password_digest :string
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates(:username,
    {
      :presence => true,
      :uniqueness => { :case_sensitive => false }
    }
  )

  has_secure_password
end
