require 'rails_helper'

feature 'user signs in', %Q{
  As a signed up user
  I want to sign in
  So that I can regain access to my account
} do
  scenario 'specify valid credentials' do
    user = FactoryBot.create(:user)

    visit new_user_session_path

    fill_in 'login-field-border-1', with: user.email
    fill_in 'login-field-border-2', with: user.password

    click_button 'Log in'

    expect(page).to have_content(`Spirits of the Forest\nHow to Play My Games Account Sign Out`)  #successful login
    expect(page).to have_content('Sign Out')
  end

  scenario 'specify invalid credentials' do
    visit new_user_session_path

    click_button 'Log in'
    expect(page).to have_content(`Spirits of the Forest\nSign In Sign Up\nEmail\nPassword\nRemember me\nSign up Forgot your password?`) #unsuccessful login
    expect(page).to_not have_content('Sign Out')
  end
end
