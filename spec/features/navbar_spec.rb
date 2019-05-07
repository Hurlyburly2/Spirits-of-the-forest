require 'rails_helper'

feature 'User signed in, and navbar links are clicked' do
  scenario 'specify valid credentials' do
    user = FactoryBot.create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit root_path
    click_link 'Account'
    expect(page).to have_content(user.username)

    click_link 'My Games'
    expect(page).to have_content('My Games Account Sign Out')

    click_link 'Sign Out'
    expect(page).to have_content('Sign In')
  end

  scenario 'specify invalid credentials' do
    visit new_user_session_path
  
    click_link 'Sign In'
    expect(page).to have_content("Sign In Sign Up\nLog in\nEmail\nPassword\nRemember me\nSign up Forgot your password?")
  
    click_link 'Sign Up'
    expect(page).to have_content('confirmation')
  end
end
