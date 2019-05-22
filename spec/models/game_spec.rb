require 'rails_helper'

RSpec.describe Game, type: :model do
  scenario "Creating a game- it has correct properties" do
    test_user = User.new(username: "Hurlyburly", password: "password", email: "email@email.com")
    test_game = Game.new
    test_match = Match.new(user: test_user, game: test_game)
    
    expect(test_game.valid?).to eq true
    expect(test_game.gamestate).to eq nil
    expect(test_game.whose_turn_id).to eq nil
    expect(test_game.concession).to eq false
    expect(test_game.gem_placed).to eq false
  end
end
