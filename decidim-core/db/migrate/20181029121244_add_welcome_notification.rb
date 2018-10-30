# frozen_string_literal: true

class AddWelcomeNotification < ActiveRecord::Migration[5.2]
  def change
    change_table :decidim_organizations do |t|
      t.boolean :send_notification_message, null: false, default: false
      t.jsonb :welcome_notification_subject, null: true
      t.jsonb :welcome_notification_message, null: true
    end
  end
end
