require 'test_helper'

class CoursesControllerTest < ActionController::TestCase
  setup do
    sign_in users(:joe)
    @university = universities(:one)
    @course = courses(:one)
  end

  test "should get index" do
    get :index, :university_id => @university
    assert_response :success
    assert_not_nil assigns(:courses)
  end

  test "should get new" do
    get :new, :university_id => @university
    assert_response :success
  end

  test "should create course" do
    assert_difference('Course.count') do
      post :create, course: { content: @course.content, instructor: @course.instructor, name: @course.name}, :university_id => @university
    end

    assert_redirected_to university_course_path(@university, assigns(:course))
  end

  test "should show course" do
    get :show, id: @course, :university_id => @university
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @course, :university_id => @university
    assert_response :success
  end

  test "should update course" do
    patch :update, id: @course, course: { content: @course.content, instructor: @course.instructor, name: @course.name}, :university_id => @university
    assert_redirected_to university_course_path(@university, assigns(:course))
  end

  test "should destroy course" do
    assert_difference('Course.count', -1) do
      delete :destroy, id: @course, :university_id => @university
    end

    assert_redirected_to university_course_path(@university, assigns(:course))
  end
end
