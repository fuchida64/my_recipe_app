class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|
      t.string :name

      t.timestamps
    end

    add_index :ingredients, :name, unique: true
  end
end
