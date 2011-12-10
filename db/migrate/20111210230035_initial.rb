class Initial < ActiveRecord::Migration
  def up
    create_table :people do |t|
      t.string :first_name, :last_name, :address
      t.string :email, :null => false
      t.boolean :verified_for_webinar, :participated_in_webinar, :received_login, :default => false, :null => false
    end
    add_index :people, :email, :unique => true

    create_table :webinars do |t|
      t.string :title
      t.text :description
      t.timestamp :start
    end

    create_table :participations do |t|
      t.integer :person_id, :webinar_id, :null => false
    end
    add_index :participations, [:person_id, :webinar_id], :unique => true

    create_table :organisations do |t|
      t.string :website, :address, :name
    end

    create_table :memberships do |t|
      t.integer :person_id, :organisation_id, :null => false
    end
    add_index :memberships, [:person_id, :organisation_id], :unique => true
  end

  def down
    drop_table :people
    drop_table :webinars
    drop_table :participations
    drop_table :memberships
    drop_table :organisations
  end
end
