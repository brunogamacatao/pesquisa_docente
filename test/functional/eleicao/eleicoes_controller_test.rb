require 'test_helper'

class Eleicao::EleicoesControllerTest < ActionController::TestCase
  setup do
    @eleicao_eleicao = eleicao_eleicoes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:eleicao_eleicoes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create eleicao_eleicao" do
    assert_difference('Eleicao::Eleicao.count') do
      post :create, eleicao_eleicao: @eleicao_eleicao.attributes
    end

    assert_redirected_to eleicao_eleicao_path(assigns(:eleicao_eleicao))
  end

  test "should show eleicao_eleicao" do
    get :show, id: @eleicao_eleicao
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @eleicao_eleicao
    assert_response :success
  end

  test "should update eleicao_eleicao" do
    put :update, id: @eleicao_eleicao, eleicao_eleicao: @eleicao_eleicao.attributes
    assert_redirected_to eleicao_eleicao_path(assigns(:eleicao_eleicao))
  end

  test "should destroy eleicao_eleicao" do
    assert_difference('Eleicao::Eleicao.count', -1) do
      delete :destroy, id: @eleicao_eleicao
    end

    assert_redirected_to eleicao_eleicoes_path
  end
end
