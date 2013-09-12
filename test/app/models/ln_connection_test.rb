require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class LnConnectionTest < Test::Unit::TestCase
  context "LnConnection Model" do
    should 'construct new instance' do
      @ln_connection = LnConnection.new
      assert_not_nil @ln_connection
    end
  end
end
