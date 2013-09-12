class CreateLnConnections < ActiveRecord::Migration
  def self.up
    create_table :ln_connections do |t|
      t.string :fkuid_from
      t.string :fkuid_to
    end
  end

  def self.down
    drop_table :ln_connections
  end
end
