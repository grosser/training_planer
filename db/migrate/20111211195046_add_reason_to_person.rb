class AddReasonToPerson < ActiveRecord::Migration
  def change
    add_column :people, :reason_to_participate, :text
  end
end
