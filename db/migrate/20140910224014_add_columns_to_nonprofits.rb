class AddColumnsToNonprofits < ActiveRecord::Migration
  def change
    change_table :nonprofits do |t|
      t.string :type
      t.string :email
      t.string :card
    end
  end
end
