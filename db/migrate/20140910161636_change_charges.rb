class ChangeCharges < ActiveRecord::Migration
  def change
    drop_table :charges
  end
end
