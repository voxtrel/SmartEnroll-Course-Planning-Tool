require "test_helper"

class CoursesSearchTest < ActionDispatch::IntegrationTest
  test "index page has a search form" do
    # This will visit the index page of courses and ensure its succesful
    get courses_url
    assert_response :success

    # Makes sure the searchbar ui and its elements are visible and exist
    assert_select "form.search-form" do
      assert_select "input[name=search]"
      assert_select "button[type=submit]", "Search"
    end
  end
end
