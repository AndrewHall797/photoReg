class CreateTagRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :tag_relations do |t|
      t.belongs_to :tag
      t.belongs_to :image
      t.timestamps
    end
  end
end
