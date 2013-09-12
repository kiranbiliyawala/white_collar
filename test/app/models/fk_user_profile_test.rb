require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class FkUserProfileTest < Test::Unit::TestCase
  context "FkUserProfile Model" do
    should 'construct new instance' do
      @fk_user_profile = FkUserProfile.new
      assert_not_nil @fk_user_profile
    end
  end
end
