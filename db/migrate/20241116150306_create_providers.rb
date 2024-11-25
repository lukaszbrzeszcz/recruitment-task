class CreateProviders < ActiveRecord::Migration[8.0]
  def change
    create_table :providers do |t|
      t.string :name
      t.string :topics

      t.timestamps
    end
  end
end