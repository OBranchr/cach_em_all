class CreateArbitraryRecords < ActiveRecord::Migration
  def change
    create_table :arbitrary_records do |t|
      t.string :name

      t.timestamps
    end
  end
end
