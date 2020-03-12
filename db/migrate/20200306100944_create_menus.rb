class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.integer :servings_for
      t.integer :user_id
      t.integer :recipe_id

      t.timestamps
    end
  end
end
