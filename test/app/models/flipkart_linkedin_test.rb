require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class FlipkartLinkedinTest < Test::Unit::TestCase
  context "FlipkartLinkedin Model" do
    should 'construct new instance' do
      @flipkart_linkedin = FlipkartLinkedin.new
      assert_not_nil @flipkart_linkedin
    end
  end
end
