class CreateRecipes < ActiveRecord::Migration
  def self.up
    create_table :recipes do |t|
      t.column :name, :string, :null => false
      t.column :instructions, :text
      t.timestamps
    end
  end

  def self.down
    drop_table :recipes
  end
end
