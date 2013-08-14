class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :secondname
      t.string :patronymic
      t.integer :dateofbirth
      t.string :login
      t.string :email

      t.timestamps
    end
  end
end