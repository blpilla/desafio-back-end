require "application_system_test_case"

class CnabsTest < ApplicationSystemTestCase
  setup do
    @cnab = cnabs(:one)
  end

  test "visiting the index" do
    visit cnabs_url
    assert_selector "h1", text: "Cnabs"
  end

  test "creating a Cnab" do
    visit cnabs_url
    click_on "New Cnab"

    fill_in "Cartao", with: @cnab.cartao
    fill_in "Cpf", with: @cnab.cpf
    fill_in "Data", with: @cnab.data
    fill_in "Dono", with: @cnab.dono
    fill_in "Hora", with: @cnab.hora
    fill_in "Loja", with: @cnab.loja
    fill_in "Tipo", with: @cnab.tipo
    fill_in "Valor", with: @cnab.valor
    click_on "Create Cnab"

    assert_text "Cnab was successfully created"
    click_on "Back"
  end

  test "updating a Cnab" do
    visit cnabs_url
    click_on "Edit", match: :first

    fill_in "Cartao", with: @cnab.cartao
    fill_in "Cpf", with: @cnab.cpf
    fill_in "Data", with: @cnab.data
    fill_in "Dono", with: @cnab.dono
    fill_in "Hora", with: @cnab.hora
    fill_in "Loja", with: @cnab.loja
    fill_in "Tipo", with: @cnab.tipo
    fill_in "Valor", with: @cnab.valor
    click_on "Update Cnab"

    assert_text "Cnab was successfully updated"
    click_on "Back"
  end

  test "destroying a Cnab" do
    visit cnabs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cnab was successfully destroyed"
  end
end
