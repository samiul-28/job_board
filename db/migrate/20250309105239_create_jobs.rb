class CreateJobs < ActiveRecord::Migration[8.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :job_type
      t.text :description
      t.date :application_deadline
      t.string :circular

      t.timestamps
    end
  end
end
