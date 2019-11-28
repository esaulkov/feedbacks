class FeedbacksMailer < ApplicationMailer
  def notify_admin
    @feedback = params[:feedback]

    mail to: ENV["ADMIN_EMAIL"], subject: "New feedback"
  end
end
