class AddDescriptionToNonprofits < ActiveRecord::Migration
  def change
    add_column :nonprofits, :description, :text

  end
end
