require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class OrderInfoTest < Test::Unit::TestCase
  context "OrderInfo Model" do
    should 'construct new instance' do
      @order_info = OrderInfo.new
      assert_not_nil @order_info
    end
  end
end
