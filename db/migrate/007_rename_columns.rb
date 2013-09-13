class RenameColumns < ActiveRecord::Migration
  def self.up
    change_table :fk_user_profiles do |t|
      t.remove :dob
      t.integer :age
    end
  end

  def self.down
    change_table :fk_user_profiles do |t|
      t.remove :age
      t.datetime :dob
    end
  end
end
