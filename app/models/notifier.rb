class Notifier <ActionMailer::Base
	default_url_options[:host] = "www.phosney.com"

	def password_reset_instructions(user)
		subject       "Password Reset Instructions"
		from          "support@phosney.com"
		recipients    user.email
		sent_on       Time.now
		body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
	end
	
	
	def shared_account_invitation(user,invitation)
	  subject       ""
	  from          "support@phosney.com"
	  recipients    invitation.recipient_email
	  sent_on       Time.now
	  body          :user_email => user.email, :create_url => create_shared_account_invitation_url(invitation.token)
  end
	
end
