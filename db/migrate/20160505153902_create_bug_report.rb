class CreateBugReport < ActiveRecord::Migration
  def change
    create_table :bug_reports do |t|
      t.string :user
      t.string :status
      t.integer :bug_report_category_id
      t.text :description


      t.timestamps null: false
    end
  end
end
