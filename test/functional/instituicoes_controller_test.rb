require 'test_helper'

class InstituicoesControllerTest < ActionController::TestCase
  setup do
    @instituicao = instituicoes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:instituicoes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create instituicao" do
    assert_difference('Instituicao.count') do
      post :create, instituicao: @instituicao.attributes
    end

    assert_redirected_to instituicao_path(assigns(:instituicao))
  end

  test "should show instituicao" do
    get :show, id: @instituicao
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @instituicao
    assert_response :success
  end

  test "should update instituicao" do
    put :update, id: @instituicao, instituicao: @instituicao.attributes
    assert_redirected_to instituicao_path(assigns(:instituicao))
  end

  test "should destroy instituicao" do
    assert_difference('Instituicao.count', -1) do
      delete :destroy, id: @instituicao
    end

    assert_redirected_to instituicoes_path
  end
end
