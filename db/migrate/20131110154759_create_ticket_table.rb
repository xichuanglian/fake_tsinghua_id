class CreateTicketTable < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :ticket
      t.integer :app_id
      t.integer :user_id
      t.string :ip
      t.timestamps
    end
  end
end
