class AddDescriptionToLineItems < ActiveRecord::Migration
  def change
    add_column :spree_line_items, :item_description, :text
  end
end
