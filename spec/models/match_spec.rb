require 'rails_helper'

RSpec.describe Match, type: :model do
  scenario "Creating a match- it has correct properties" do
    test_user = User.new(username: "Hurlyburly", password: "password", email: "email@email.com")
    test_game = Game.new
    test_match = Match.new(user: test_user, game: test_game)

    expect(test_match.user).to be test_user
    expect(test_match.game).to be test_game
    expect(test_match.endgame_confirm).to be false
    expect(test_match.selected_cards).to be nil
    expect(test_match.tokens).to be nil
    expect(test_match.reminded).to be false
    expect(test_match.gems_possessed).to be 3
    expect(test_match.gems_total).to be 3
  end
end
