require 'test_helper'

class TurmasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:turmas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create turma" do
    assert_difference('Turma.count') do
      post :create, :turma => { }
    end

    assert_redirected_to turma_path(assigns(:turma))
  end

  test "should show turma" do
    get :show, :id => turmas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => turmas(:one).to_param
    assert_response :success
  end

  test "should update turma" do
    put :update, :id => turmas(:one).to_param, :turma => { }
    assert_redirected_to turma_path(assigns(:turma))
  end

  test "should destroy turma" do
    assert_difference('Turma.count', -1) do
      delete :destroy, :id => turmas(:one).to_param
    end

    assert_redirected_to turmas_path
  end
end
