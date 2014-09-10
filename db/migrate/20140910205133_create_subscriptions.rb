class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.belongs_to :customer
      t.belongs_to :nonprofit
      t.belongs_to :plan
    end
  end
end
