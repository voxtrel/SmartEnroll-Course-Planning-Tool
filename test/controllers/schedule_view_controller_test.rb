require "test_helper"

class ScheduleViewControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student = students(:one) # from fixtures
    post login_url, params: { email: @student.email, password: "password" }
  end

  test "should get index" do
    get schedule_view_index_url
    assert_response :success
  end
end
