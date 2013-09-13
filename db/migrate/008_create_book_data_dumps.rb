class CreateBookDataDumps < ActiveRecord::Migration
  def self.up
    create_table :book_data_dumps do |t|
      t.string :fsn
      t.string :title
      t.float :mrp
      t.string :mrp_currency
      t.float :fsp
      t.string :fsp_currency
    end
  end

  def self.down
    drop_table :book_data_dumps
  end
end
