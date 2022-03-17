require "test_helper"

class PuzzleHuntsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get puzzle_hunts_index_url
    assert_response :success
  end
end
