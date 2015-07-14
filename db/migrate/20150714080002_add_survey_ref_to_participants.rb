class AddSurveyRefToParticipants < ActiveRecord::Migration
  def change
    add_reference :participants, :survey, index: true
    add_foreign_key :participants, :surveys
  end
end
