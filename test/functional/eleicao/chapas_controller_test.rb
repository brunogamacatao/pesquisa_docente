require 'test_helper'

class Eleicao::ChapasControllerTest < ActionController::TestCase
  setup do
    @eleicao_chapa = eleicao_chapas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:eleicao_chapas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create eleicao_chapa" do
    assert_difference('Eleicao::Chapa.count') do
      post :create, eleicao_chapa: @eleicao_chapa.attributes
    end

    assert_redirected_to eleicao_chapa_path(assigns(:eleicao_chapa))
  end

  test "should show eleicao_chapa" do
    get :show, id: @eleicao_chapa
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @eleicao_chapa
    assert_response :success
  end

  test "should update eleicao_chapa" do
    put :update, id: @eleicao_chapa, eleicao_chapa: @eleicao_chapa.attributes
    assert_redirected_to eleicao_chapa_path(assigns(:eleicao_chapa))
  end

  test "should destroy eleicao_chapa" do
    assert_difference('Eleicao::Chapa.count', -1) do
      delete :destroy, id: @eleicao_chapa
    end

    assert_redirected_to eleicao_chapas_path
  end
end
