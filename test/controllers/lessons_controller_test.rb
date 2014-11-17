require 'test_helper'

class LessonsControllerTest < ActionController::TestCase
  setup do
    @lesson = lessons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lessons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lesson" do
    assert_difference('Lesson.count') do
      post :create, lesson: { description: @lesson.description, end_date: @lesson.end_date, ends_at: @lesson.ends_at, fri: @lesson.fri, g1_3: @lesson.g1_3, g3_5: @lesson.g3_5, g6_8: @lesson.g6_8, instructor: @lesson.instructor, location: @lesson.location, max_enrollment: @lesson.max_enrollment, mon: @lesson.mon, starts_at: @lesson.starts_at, thu: @lesson.thu, title: @lesson.title, tue: @lesson.tue, wed: @lesson.wed }
    end

    assert_redirected_to lesson_path(assigns(:lesson))
  end

  test "should show lesson" do
    get :show, id: @lesson
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lesson
    assert_response :success
  end

  test "should update lesson" do
    patch :update, id: @lesson, lesson: { description: @lesson.description, end_date: @lesson.end_date, ends_at: @lesson.ends_at, fri: @lesson.fri, g1_3: @lesson.g1_3, g3_5: @lesson.g3_5, g6_8: @lesson.g6_8, instructor: @lesson.instructor, location: @lesson.location, max_enrollment: @lesson.max_enrollment, mon: @lesson.mon, starts_at: @lesson.starts_at, thu: @lesson.thu, title: @lesson.title, tue: @lesson.tue, wed: @lesson.wed }
    assert_redirected_to lesson_path(assigns(:lesson))
  end

  test "should destroy lesson" do
    assert_difference('Lesson.count', -1) do
      delete :destroy, id: @lesson
    end

    assert_redirected_to lessons_path
  end
end
