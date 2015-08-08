class AddApkToSurvey < ActiveRecord::Migration
  def up
    add_attachment :surveys, :apk
  end

  def down
    remove_attachment :surevys, :apk
  end
end
