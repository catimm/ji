class AddIntroVideoIdToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :intro_video_id, :string
  end
end
