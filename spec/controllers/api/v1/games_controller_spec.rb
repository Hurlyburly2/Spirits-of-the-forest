require 'rails_helper'

RSpec.describe Api::V1::GamesController, type: :controller do
  describe 'GET#index' do
    it "should get all of the user's games" do
      user = User.create(email: "email@email.com", password: "password", username: "USERNAME")
      sign_in user
      
      game_one = Game.create()
      match_one = Match.create(user: user, game: game_one)
      game_two = Game.create()
      match_two = Match.create(user: user, game: game_two)
      
      get :index
      return_json = JSON.parse(response.body)
      
      expect(response.status).to eq 200
      expect(response.content_type).to eq ("application/json")
      
      expect(return_json["current_user"]["email"]).to eq("email@email.com")
      expect(return_json["current_user"]["username"]).to eq("USERNAME")
      
      expect(return_json["games"].length).to eq 2
    end
  end
  
  describe 'POST#create' do
    it "should correctly create a new game" do
      user = User.create(email: "email@email.com", password: "password", username: "USERNAME")
      
      params = {
        id: user.id,
        email: "email@email.com",
        username: "USERNAME"
      }.to_json
      
      prev_count = Game.count
      post :create, body: params
      expect(Game.count).to eq(prev_count + 1)
    end
    
    it "returns the json of the newly created game" do
      user = User.create(email: "email@email.com", password: "password", username: "USERNAME")
      
      params = {
        id: user.id,
        email: "email@email.com",
        username: "USERNAME"
      }.to_json
      
      post :create, body: params
      returned_json = JSON.parse(response.body)
      
      expect(returned_json["games"]["users"][0]["id"]).to eq(user.id)
      expect(returned_json["games"]["users"][0]["username"]).to eq(user.username)
    end
  end
end
