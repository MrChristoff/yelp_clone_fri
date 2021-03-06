require 'rails_helper'
require 'web_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No Restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'User cannot add new restaurant when not logged in' do
    scenario 'Redirected to sign in page' do
      visit '/'
      click_link 'Add a restaurant'
      expect(current_path).to eq '/users/sign_in'
      # expect(page).not_to have_link('Add a restaurant')
    end
  end

  context 'restaurants have been added' do
  before do
    Restaurant.create(name: 'Kung Food')
  end

  scenario 'display restaurants' do
    visit '/restaurants'
    expect(page).to have_content('Kung Food')
    expect(page).not_to have_content('No restaurants yet')
  end
end

  context 'creating restaurants' do

    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      sign_up
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Kung Food'
      click_button 'Create Restaurant'
      expect(page).to have_content 'Kung Food'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'does not allow to you to submit a name that is too short' do
      sign_up
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KF'
      click_button 'Create Restaurant'
      expect(page).not_to have_css 'h2', text: 'kf'
      expect(page).to have_content 'error'
    end
  end

  context 'viewing restaurants' do

    let!(:kungfood){ Restaurant.create(name:'Kung Food')}

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'Kung Food'
      expect(page).to have_content 'Kung Food'
      expect(current_path).to eq "/restaurants/#{kungfood.id}"
    end
  end

  context 'editing restaurants' do
    before { Restaurant.create name: 'Kung Food', description: "Generic food" }

    scenario 'let a user edit a restaurant' do
      sign_up
      visit 'restaurants'
      click_link 'Edit Kung Food'
      fill_in 'Name', with: 'Kung F-ing amazing food'
      fill_in 'Description', with: 'Proper tasty'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kung F-ing amazing food'
      expect(page).to have_content 'Proper tasty'
      expect(current_path).to eq "/restaurants"
    end
  end

  context 'deleting restaurants' do
    before { Restaurant.create name: 'KFC', description: 'Deep fried badness' }

    scenario 'removes a restaurant when a user clicks a delete link' do
      sign_up
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end

end
