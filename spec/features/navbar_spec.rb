require 'rails_helper'

feature 'User signed in, and navbar links are clicked' do
  scenario 'specify valid credentials' do
    user = FactoryBot.create(:user)
    visit new_user_session_path

    fill_in 'login-field-border-1', with: user.email
    fill_in 'login-field-border-2', with: user.password
    click_button 'Log in'

    visit root_path
    click_link 'Account'
    expect(page).to have_content(user.username)

    click_link 'My Games'
    expect(page).to have_content('My Games')

    click_link 'Sign Out'
    expect(page).to have_content('Sign In')
  end

  scenario 'specify invalid credentials' do
    visit new_user_session_path

    click_link 'Sign In'
    expect(page).to have_content("Remember me")

    click_link 'Sign Up'
    expect(page).to have_content('confirmation')
  end
end
