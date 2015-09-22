class AddParticipantRefToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :participant, index: true
    add_foreign_key :events, :participants
  end
end
