class AddImageToLineItems < ActiveRecord::Migration
  def up
    add_attachment :spree_line_items, :image
  end

  def down
    remove_attachment :spree_line_items, :image
  end
end
