class AddColumnsToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :camera_six, :string
    add_column :problems, :first_topic, :string
    add_column :problems, :first_topic_q1, :text
    add_column :problems, :first_topic_q2, :text
    add_column :problems, :first_topic_q3, :text
    add_column :problems, :second_topic, :string
    add_column :problems, :second_topic_q1, :text
    add_column :problems, :second_topic_q2, :text
    add_column :problems, :second_topic_q3, :text
    add_column :problems, :third_topic, :string
    add_column :problems, :third_topic_q1, :text
    add_column :problems, :third_topic_q2, :text
    add_column :problems, :third_topic_q3, :text
  end
end
