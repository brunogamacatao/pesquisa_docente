require 'test_helper'

class RespostasControllerTest < ActionController::TestCase
  setup do
    @resposta = respostas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:respostas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create resposta" do
    assert_difference('Resposta.count') do
      post :create, resposta: @resposta.attributes
    end

    assert_redirected_to resposta_path(assigns(:resposta))
  end

  test "should show resposta" do
    get :show, id: @resposta
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @resposta
    assert_response :success
  end

  test "should update resposta" do
    put :update, id: @resposta, resposta: @resposta.attributes
    assert_redirected_to resposta_path(assigns(:resposta))
  end

  test "should destroy resposta" do
    assert_difference('Resposta.count', -1) do
      delete :destroy, id: @resposta
    end

    assert_redirected_to respostas_path
  end
end
