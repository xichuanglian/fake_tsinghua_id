class CreateUserTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :thuid
      t.string :username
      t.string :password
      t.string :real_name
      t.string :user_type
      t.string :department
      t.string :email
    end
  end
end
