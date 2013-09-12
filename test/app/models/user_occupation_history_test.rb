require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class UserOccupationHistoryTest < Test::Unit::TestCase
  context "UserOccupationHistory Model" do
    should 'construct new instance' do
      @user_occupation_history = UserOccupationHistory.new
      assert_not_nil @user_occupation_history
    end
  end
end
