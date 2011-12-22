class AddReceiveEmailsToPeople < ActiveRecord::Migration
  def change
    add_column :people, :receive_emails, :boolean, :default => true, :null => false
  end
end
