# == Schema Information
#
# Table name: follow_requests
#
#  id           :integer          not null, primary key
#  status       :string           accepted / rejected / pending
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recipient_id :integer
#  sender_id    :integer
#
class FollowRequest < ApplicationRecord
  def FollowRequest.request_status(sender, receiver)
    request = FollowRequest.where({:sender_id => sender}).where({:recipient_id => receiver}).first
    if request == nil
      return "not_found"
    else 
      return request.status
    end
  end

  def request_sender
    return User.where({ :id => self.sender_id}).first
  end

end
