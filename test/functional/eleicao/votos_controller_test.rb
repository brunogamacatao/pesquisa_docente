require 'test_helper'

class Eleicao::VotosControllerTest < ActionController::TestCase
  setup do
    @eleicao_voto = eleicao_votos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:eleicao_votos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create eleicao_voto" do
    assert_difference('Eleicao::Voto.count') do
      post :create, eleicao_voto: @eleicao_voto.attributes
    end

    assert_redirected_to eleicao_voto_path(assigns(:eleicao_voto))
  end

  test "should show eleicao_voto" do
    get :show, id: @eleicao_voto
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @eleicao_voto
    assert_response :success
  end

  test "should update eleicao_voto" do
    put :update, id: @eleicao_voto, eleicao_voto: @eleicao_voto.attributes
    assert_redirected_to eleicao_voto_path(assigns(:eleicao_voto))
  end

  test "should destroy eleicao_voto" do
    assert_difference('Eleicao::Voto.count', -1) do
      delete :destroy, id: @eleicao_voto
    end

    assert_redirected_to eleicao_votos_path
  end
end
