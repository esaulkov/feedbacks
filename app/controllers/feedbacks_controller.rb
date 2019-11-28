class FeedbacksController < ApplicationController
  def new
    @feedback = Feedback.new
    @feedback.username = current_user.try(:full_name)
    @feedback.email = current_user.try(:email)
  end

  def create
    @feedback = Feedback.new(feedback_params)

    if @feedback.save
      send_email_to_admin
      redirect_to new_feedback_url, notice: "Your message was successfully delivered. Thank you!"
    else
      render :new
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:username, :email, :message)
  end

  def send_email_to_admin
    FeedbacksMailer.with(feedback: @feedback).notify_admin.deliver_later
  end
end
