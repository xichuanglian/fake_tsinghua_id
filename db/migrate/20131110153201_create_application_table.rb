class CreateApplicationTable < ActiveRecord::Migration
  def change
    create_table :thu_apps do |t|
      t.string :appid
      t.string :name
      t.integer :seq
      t.string :prefix
      t.string :default_path
    end
  end
end
