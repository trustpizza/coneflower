require "application_system_test_case"

class DevelopmentsTest < ApplicationSystemTestCase
  setup do
    @development = developments(:one)
  end

  test "visiting the index" do
    visit developments_url
    assert_selector "h1", text: "Developments"
  end

  test "should create development" do
    visit developments_url
    click_on "New development"

    fill_in "Acreage", with: @development.acreage
    fill_in "Address", with: @development.address
    fill_in "Description", with: @development.description
    fill_in "Name", with: @development.name
    fill_in "Planned end date", with: @development.planned_end_date
    fill_in "Planned start date", with: @development.planned_start_date
    fill_in "Website", with: @development.website
    click_on "Create Development"

    assert_text "Development was successfully created"
    click_on "Back"
  end

  test "should update Development" do
    visit development_url(@development)
    click_on "Edit this development", match: :first

    fill_in "Acreage", with: @development.acreage
    fill_in "Address", with: @development.address
    fill_in "Description", with: @development.description
    fill_in "Name", with: @development.name
    fill_in "Planned end date", with: @development.planned_end_date
    fill_in "Planned start date", with: @development.planned_start_date
    fill_in "Website", with: @development.website
    click_on "Update Development"

    assert_text "Development was successfully updated"
    click_on "Back"
  end

  test "should destroy Development" do
    visit development_url(@development)
    click_on "Destroy this development", match: :first

    assert_text "Development was successfully destroyed"
  end
end
