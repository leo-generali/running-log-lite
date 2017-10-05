class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t| 
      t.string :title
      t.text :desc
      t.time :time
      t.date :date
      t.float :warmup
      t.float :activity
      t.float :cooldown
      t.boolean :race
      t.boolean :workout

      t.timestamps
    end
  end
end
