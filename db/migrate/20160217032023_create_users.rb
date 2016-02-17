class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid
      t.string :name
      t.string :nickname
      t.string :email
      t.string :image_url
      t.string :bio
      t.string :website
      t.string :token
      t.string :provider

      t.timestamps null: false
    end
  end
end
