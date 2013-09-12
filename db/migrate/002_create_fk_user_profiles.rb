class CreateFkUserProfiles < ActiveRecord::Migration
  def self.up
    create_table :fk_user_profiles do |t|
      t.string :fkuid
      t.string :name
      t.string :gender
      t.datetime :dob
      t.string :city
      t.string :state
    end
  end

  def self.down
    drop_table :fk_user_profiles
  end
end
