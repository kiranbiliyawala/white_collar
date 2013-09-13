require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class BookDataDumpTest < Test::Unit::TestCase
  context "BookDataDump Model" do
    should 'construct new instance' do
      @book_data_dump = BookDataDump.new
      assert_not_nil @book_data_dump
    end
  end
end
