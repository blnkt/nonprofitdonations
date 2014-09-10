class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.integer :amount
      t.string :interval
      t.string :stripeid
      t.belongs_to :nonprofit

    end
  end
end
