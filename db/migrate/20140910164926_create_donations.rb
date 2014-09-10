class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.belongs_to :customer
      t.belongs_to :nonprofit
      t.integer :amount
    end
  end
end
