class RenameWebinarsToTrainings < ActiveRecord::Migration
  def change
    rename_table :webinars, :trainings
    rename_column :participations, :webinar_id, :training_id
    rename_column :people, :verified_for_webinar, :verified_for_training
  end
end
