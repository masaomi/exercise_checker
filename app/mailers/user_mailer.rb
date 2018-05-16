class UserMailer < ActionMailer::Base
  default from: "bio673.2014@gmail.com"


  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.registration_confirmation.subject
  #
  def registration_confirmation
    @greeting = "Hi"
 
    mail to: "masaomi.hatakeyama@gmail.com", subject: "ActionMailer test"
  end
end
