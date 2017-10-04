class UserMailer < ApplicationMailer
	 default from: "from@example.com"

  def contact_form(email, name, message)
  	@message = message
    mail(from: email,
         to: 'alina.ghetler@gmail.com',
         subject: "A new contact form message from #{name}")
  	end
  	def new_registration(user)
   		@user = user 
   		mail(:to => user.email, :subject => "Welcome to Alina Berlin GmBH!!!")
  	end
end
