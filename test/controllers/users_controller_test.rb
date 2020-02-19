require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.first
  end

  test "should get show" do
    get user_path(@user)
    assert_response :success
  end

end
