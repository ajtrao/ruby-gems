class RemoveStartTimeFromCourses < ActiveRecord::Migration[6.1]
  def change
    remove_column :courses, :start_time, :time
    add_column :courses, :start, :datetime
  end
end
