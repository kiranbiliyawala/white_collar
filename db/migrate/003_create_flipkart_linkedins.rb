class CreateFlipkartLinkedins < ActiveRecord::Migration
  def self.up
    create_table :flipkart_linkedins do |t|
      t.string :fkuid
      t.string :lnid
    end
  end

  def self.down
    drop_table :flipkart_linkedins
  end
end
