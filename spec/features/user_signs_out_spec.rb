require 'rails_helper'

feature 'user signs out', %Q{
  As an authenticated user
  I want to sign out
  So that my identity is forgotten about on the machine I'm using
} do
  # Acceptance Criteria
  # * If I'm signed in, I have an option to sign out
  # * When I opt to sign out, I get a confirmation that my identity has been
  #   forgotten on the machine I'm using

  scenario 'authenticated user signs out' do
    user = FactoryBot.create(:user)

    visit new_user_session_path

    fill_in 'login-field-border-1', with: user.email
    fill_in 'login-field-border-2', with: user.password

    click_button 'Log in'

    expect(page).to have_content(`Spirits of the Forest\nHow to Play My Games Account Sign Out`) #successful login

    click_link 'Sign Out'
    expect(page).to have_content(`Spirits of the Forest\nSign In Sign Up\n\"Once an age, a mythic wind lifts the veil between the spirit world and ours. Whimsical seraphs, drawn to the vigor of an ancient forest, descend through clouds to once again take up their centennial game. You are one of these seraphs – a being of great power and curiosity. The life of the forest fascinates you, and you eagerly gather plant, animal, and sprite alike to add to your mystical menagerie. But beware, for you are not alone. Other beings just like yourself contest to collect the life of the forest as well!\"\nSign In Sign Up`) #successful signout
  end

  scenario 'unauthenticated user attempts to sign out' do
    visit '/'
    expect(page).to_not have_content('Sign Out')
  end
end
