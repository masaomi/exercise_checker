class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :q1
      t.string :q2
      t.string :q3
      t.string :q4
      t.string :q5
      t.text   :sources
      t.text   :results
      t.text   :comments
      t.string :password
      t.string :name

      t.timestamps
    end
  end
end
