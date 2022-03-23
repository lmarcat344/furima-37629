class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text       :contents, null: false
      t.integer    :user_id,     null: false
      t.integer    :item_id,     null: false
      t.timestamps
    end
  end
end
