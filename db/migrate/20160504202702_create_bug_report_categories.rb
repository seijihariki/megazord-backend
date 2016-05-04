class CreateBugReportCategories < ActiveRecord::Migration
  def change
    create_table :bug_report_categories do |t|
    	t.string :name
      t.timestamps null: false
    end
  end
end
