require 'features/features_spec_helper'

feature "Registration", :devise do
  scenario "Visitor registers successfully via register form" do
    visit new_costumer_registration_path
    within '#new_costumer' do
      fill_in 'Firstname', with: "Johnny"
      fill_in 'Lastname', with: "Ring"
      fill_in 'Email', with: "johnny@mail.ru"
      fill_in'Password', with: '12345678'
      fill_in'Password confirmation', with: '12345678'
      click_button('Sign up')
    end
    expect(page).to have_content 'Logout'
    
    expect(page).not_to have_content 'Sign up'

  end
 
  end

