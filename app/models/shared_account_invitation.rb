class SharedAccountInvitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  
  before_create :generate_token
  validates_presence_of :recipient_email
  validates_uniqueness_of :recipient_email, :scope => :user_id
  def send_invitation(user)
  	Notifier.deliver_shared_account_invitation(user,self)
  end
  
private  
  
  
  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end
end
