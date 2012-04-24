require 'test_helper'

class CoordenadoresControllerTest < ActionController::TestCase
  setup do
    @coordenador = coordenadores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:coordenadores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coordenador" do
    assert_difference('Coordenador.count') do
      post :create, coordenador: @coordenador.attributes
    end

    assert_redirected_to coordenador_path(assigns(:coordenador))
  end

  test "should show coordenador" do
    get :show, id: @coordenador
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @coordenador
    assert_response :success
  end

  test "should update coordenador" do
    put :update, id: @coordenador, coordenador: @coordenador.attributes
    assert_redirected_to coordenador_path(assigns(:coordenador))
  end

  test "should destroy coordenador" do
    assert_difference('Coordenador.count', -1) do
      delete :destroy, id: @coordenador
    end

    assert_redirected_to coordenadores_path
  end
end
