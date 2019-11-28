class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@feedbacks-staging.herokuapp.com'
  layout "mailer"
end
