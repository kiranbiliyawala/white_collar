class CreateUserOccupationHistories < ActiveRecord::Migration
  def self.up
    create_table :user_occupation_histories do |t|
      t.string :fkuid
      t.string :designation
      t.string :company
      t.datetime :date
    end
  end

  def self.down
    drop_table :user_occupation_histories
  end
end
