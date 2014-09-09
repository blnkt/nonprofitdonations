class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.belongs_to :customer
      t.integer :amount
      t.string :description
      t.string :currency
    end
  end
end
