require 'test_helper'

class CnabsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cnab = cnabs(:one)
  end

  test "should get index" do
    get cnabs_url
    assert_response :success
  end

  test "should get new" do
    get new_cnab_url
    assert_response :success
  end

  test "should create cnab" do
    assert_difference('Cnab.count') do
      post cnabs_url, params: { cnab: { cartao: @cnab.cartao, cpf: @cnab.cpf, data: @cnab.data, dono: @cnab.dono, hora: @cnab.hora, loja: @cnab.loja, tipo: @cnab.tipo, valor: @cnab.valor } }
    end

    assert_redirected_to cnab_url(Cnab.last)
  end

  test "should show cnab" do
    get cnab_url(@cnab)
    assert_response :success
  end

  test "should get edit" do
    get edit_cnab_url(@cnab)
    assert_response :success
  end

  test "should update cnab" do
    patch cnab_url(@cnab), params: { cnab: { cartao: @cnab.cartao, cpf: @cnab.cpf, data: @cnab.data, dono: @cnab.dono, hora: @cnab.hora, loja: @cnab.loja, tipo: @cnab.tipo, valor: @cnab.valor } }
    assert_redirected_to cnab_url(@cnab)
  end

  test "should destroy cnab" do
    assert_difference('Cnab.count', -1) do
      delete cnab_url(@cnab)
    end

    assert_redirected_to cnabs_url
  end
end
