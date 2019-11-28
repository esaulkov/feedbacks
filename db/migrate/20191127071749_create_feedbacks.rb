class CreateFeedbacks < ActiveRecord::Migration[5.1]
  def change
    create_table :feedbacks do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.text :message, limit: 1200

      t.timestamps
    end
  end
end
