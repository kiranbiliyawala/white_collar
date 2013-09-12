class CreateOrderInfos < ActiveRecord::Migration
  def self.up
    create_table :order_infos do |t|
      t.string :fkuid
      t.string :fsn
      t.string :category
      t.datetime :order_date
    end
  end

  def self.down
    drop_table :order_infos
  end
end
