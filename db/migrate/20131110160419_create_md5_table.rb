class CreateMd5Table < ActiveRecord::Migration
  def change
    create_table :md5_maps do |t|
      t.string :md5
      t.string :appid
    end
  end
end
