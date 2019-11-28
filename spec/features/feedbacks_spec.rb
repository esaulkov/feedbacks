require "rails_helper"

feature "Send feedback" do
  let(:feedback) { build :feedback }

  feature "User logged in" do
    include_context "current user signed in"

    background do
      visit new_feedback_path
    end

    scenario "Fields are filled with user data" do
      expect(page).to have_field("Username", current_user.full_name)
      expect(page).to have_field("Email", current_user.email)
    end

    scenario "User sends feedback" do
      fill_in "Message", with: feedback.message
      expect { click_button "Send" }.to change(Feedback, :count).by(1)

      expect(page).to have_content("Your message was successfully delivered. Thank you!")

      open_email(ENV["ADMIN_EMAIL"])

      expect(current_email).to have_subject("New feedback")
      expect(current_email).to have_body_text(feedback.message)
    end
  end

  feature "User doesn't logged in" do
    background do
      visit new_feedback_path
    end

    scenario "Fields are blank" do
      expect(page).to have_field("Username", "")
      expect(page).to have_field("Email", "")
    end

    scenario "User doesn't fill username field" do
      fill_in "Email", with: feedback.email
      fill_in "Message", with: feedback.message
      expect { click_button "Send" }.not_to change(Feedback, :count)

      expect(page).not_to have_content("Your message was successfully delivered. Thank you!")
      expect(page).to have_content("can't be blank")
    end

    scenario "User doesn't fill email field" do
      fill_in "Username", with: feedback.username
      fill_in "Message", with: feedback.message
      expect { click_button "Send" }.not_to change(Feedback, :count)

      expect(page).not_to have_content("Your message was successfully delivered. Thank you!")
      expect(page).to have_content("can't be blank")
    end
  end
end
