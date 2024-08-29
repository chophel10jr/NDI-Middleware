class CreateNdiWebhookRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :ndi_webhook_records do |t|
      t.boolean :executed

      t.timestamps
    end
  end
end
