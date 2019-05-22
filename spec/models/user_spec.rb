require 'rails_helper'

# USE ".TO EQ" AND ".TO INCLUDE" FOR ERRORS ARRAY
RSpec.describe User, type: :model do
  scenario "Required entries exist" do
    test_user = User.new(username: "", password: "", email: "")
    expect(test_user.valid?).to eq false

    test_user = User.new(username: "Username", password: "password", email: "")
    expect(test_user.valid?).to eq false

    test_user = User.new(username: "Username", password: "", email: "email@email.com")
    expect(test_user.valid?).to eq false

    test_user = User.new(username: "", password: "password", email: "email@email.com")
    expect(test_user.valid?).to eq false
  end

  scenario "Invalid Usernames are not allowed" do
    User.create(username: "NametoDup", password: "password", email: "someplace@email.com")
    test_user = User.create(username: "NametoDup", password: "password", email: "fasdkjfhak@email.com")
    expect(test_user.valid?).to eq false

    test_user.username = "a"
    expect(test_user.valid?).to eq false

    test_user.username = "fafhjkdshaflksadhflkashlhfla"
    expect(test_user.valid?).to eq false
  end

  scenario "Invalid emails are not allowed" do
    test_user = User.new(username: "Username", password: "password", email: "@email.com")
    expect(test_user.valid?).to eq false
    test_user = User.new(username: "Username", password: "password", email: "email@email")
    test_user = User.new(username: "Username", password: "password", email: "@")
    expect(test_user.valid?).to eq false

    User.create(username: "Username", password: "password", email: "email@email.com")
    test_user = User.new(username: "AnotherName", password: "password", email: "email@email.com")

    expect(test_user.valid?).to eq false
  end
  
  scenario "With correct information, a user is created:" do
    test_user = User.create(username: "Username", password: "password", email: "email@email.com")
    expect(test_user.valid?).to eq true
    
    expect(test_user.wins).to eq 0
    expect(test_user.losses).to eq 0
    expect(test_user.rank).to eq "bronze"
    expect(test_user.rankup_score).to eq 0
    expect(test_user.which_profile_pic).to be_between(1, 10)
  end
  
  scenario "User ranking correctly updates upon win" do
    test_user = User.create(username: "Username", password: "password", email: "email@email.com")
    expect(test_user.rankup_score).to eq 0
    
    User.ranking_change(test_user, "win")
    expect(test_user.rankup_score).to eq 10
    expect(test_user.rank).to eq "bronze"
    
    test_user.rankup_score = 99
    User.ranking_change(test_user, "win")
    expect(test_user.rankup_score).to eq 109
    expect(test_user.rank).to eq "silver"
    
    User.ranking_change(test_user, "win")
    expect(test_user.rankup_score).to eq 119
    expect(test_user.rank).to eq "silver"
    
    test_user.rankup_score = 199
    User.ranking_change(test_user, "win")
    expect(test_user.rankup_score).to eq 209
    expect(test_user.rank).to eq "gold"
    
    User.ranking_change(test_user, "win")
    expect(test_user.rankup_score).to eq 219
    expect(test_user.rank).to eq "gold"
    
    test_user.rankup_score = 299
    User.ranking_change(test_user, "win")
    expect(test_user.rankup_score).to eq 309
    expect(test_user.rank).to eq "diamond"
    
    User.ranking_change(test_user, "win")
    expect(test_user.rankup_score).to eq 319
    expect(test_user.rank).to eq "diamond"
    
    test_user.rankup_score = 399
    User.ranking_change(test_user, "win")
    expect(test_user.rankup_score).to eq 409
    expect(test_user.rank).to eq "master"
    
    User.ranking_change(test_user, "win")
    expect(test_user.rankup_score).to eq 419
    expect(test_user.rank).to eq "master"
  end
  
  scenario "User ranking correctly updates upon loss" do
    test_user = User.create(username: "Username", password: "password", email: "email@email.com")
    test_user.rank = "master"
    test_user.rankup_score = 410
    
    User.ranking_change(test_user, "loss")
    expect(test_user.rank).to eq "master"
    expect(test_user.rankup_score).to eq 401
    
    User.ranking_change(test_user, "loss")
    expect(test_user.rank).to eq "diamond"
    expect(test_user.rankup_score).to eq 392
    
    test_user.rankup_score = 308
    User.ranking_change(test_user, "loss")
    expect(test_user.rank).to eq "diamond"
    expect(test_user.rankup_score).to eq 301
    
    User.ranking_change(test_user, "loss")
    expect(test_user.rank).to eq "gold"
    expect(test_user.rankup_score).to eq 294
    
    test_user.rankup_score = 206
    User.ranking_change(test_user, "loss")
    expect(test_user.rank).to eq "gold"
    expect(test_user.rankup_score).to eq 201
    
    User.ranking_change(test_user, "loss")
    expect(test_user.rank).to eq "silver"
    expect(test_user.rankup_score).to eq 196
    
    test_user.rankup_score = 105
    User.ranking_change(test_user, "loss")
    expect(test_user.rank).to eq "silver"
    expect(test_user.rankup_score).to eq 101
    
    User.ranking_change(test_user, "loss")
    expect(test_user.rank).to eq "bronze"
    expect(test_user.rankup_score).to eq 97
    
    User.ranking_change(test_user, "loss")
    expect(test_user.rank).to eq "bronze"
    expect(test_user.rankup_score).to eq 94
  end
  
  scenario "User images return correct URL" do
    test_user = User.create(username: "Username", password: "password", email: "email@email.com")
    test_user.which_profile_pic = 1
    expect(User.return_image_url("bronze", test_user.which_profile_pic)).to eq "/rankicons/BranchBronze.png"
    expect(User.return_image_url("silver", test_user.which_profile_pic)).to eq "/rankicons/BranchSilver.png"
    expect(User.return_image_url("gold", test_user.which_profile_pic)).to eq "/rankicons/BranchGold.png"
    expect(User.return_image_url("diamond", test_user.which_profile_pic)).to eq "/rankicons/BranchDiamond.png"
    expect(User.return_image_url("master", test_user.which_profile_pic)).to eq "/rankicons/BranchMaster.png"
    
    test_user.which_profile_pic = 2
    expect(User.return_image_url("bronze", test_user.which_profile_pic)).to eq "/rankicons/DewBronze.png"
    expect(User.return_image_url("silver", test_user.which_profile_pic)).to eq "/rankicons/DewSilver.png"
    expect(User.return_image_url("gold", test_user.which_profile_pic)).to eq "/rankicons/DewGold.png"
    expect(User.return_image_url("diamond", test_user.which_profile_pic)).to eq "/rankicons/DewDiamond.png"
    expect(User.return_image_url("master", test_user.which_profile_pic)).to eq "/rankicons/DewMaster.png"
    
    test_user.which_profile_pic = 3
    expect(User.return_image_url("bronze", test_user.which_profile_pic)).to eq "/rankicons/FlowerBronze.png"
    expect(User.return_image_url("silver", test_user.which_profile_pic)).to eq "/rankicons/FlowerSilver.png"
    expect(User.return_image_url("gold", test_user.which_profile_pic)).to eq "/rankicons/FlowerGold.png"
    expect(User.return_image_url("diamond", test_user.which_profile_pic)).to eq "/rankicons/FlowerDiamond.png"
    expect(User.return_image_url("master", test_user.which_profile_pic)).to eq "/rankicons/FlowerMaster.png"
    
    test_user.which_profile_pic = 4
    expect(User.return_image_url("bronze", test_user.which_profile_pic)).to eq "/rankicons/FruitBronze.png"
    expect(User.return_image_url("silver", test_user.which_profile_pic)).to eq "/rankicons/FruitSilver.png"
    expect(User.return_image_url("gold", test_user.which_profile_pic)).to eq "/rankicons/FruitGold.png"
    expect(User.return_image_url("diamond", test_user.which_profile_pic)).to eq "/rankicons/FruitDiamond.png"
    expect(User.return_image_url("master", test_user.which_profile_pic)).to eq "/rankicons/FruitMaster.png"
    
    test_user.which_profile_pic = 5
    expect(User.return_image_url("bronze", test_user.which_profile_pic)).to eq "/rankicons/MossBronze.png"
    expect(User.return_image_url("silver", test_user.which_profile_pic)).to eq "/rankicons/MossSilver.png"
    expect(User.return_image_url("gold", test_user.which_profile_pic)).to eq "/rankicons/MossGold.png"
    expect(User.return_image_url("diamond", test_user.which_profile_pic)).to eq "/rankicons/MossDiamond.png"
    expect(User.return_image_url("master", test_user.which_profile_pic)).to eq "/rankicons/MossMaster.png"
    
    test_user.which_profile_pic = 6
    expect(User.return_image_url("bronze", test_user.which_profile_pic)).to eq "/rankicons/MushroomBronze.png"
    expect(User.return_image_url("silver", test_user.which_profile_pic)).to eq "/rankicons/MushroomSilver.png"
    expect(User.return_image_url("gold", test_user.which_profile_pic)).to eq "/rankicons/MushroomGold.png"
    expect(User.return_image_url("diamond", test_user.which_profile_pic)).to eq "/rankicons/MushroomDiamond.png"
    expect(User.return_image_url("master", test_user.which_profile_pic)).to eq "/rankicons/MushroomMaster.png"
    
    test_user.which_profile_pic = 7
    expect(User.return_image_url("bronze", test_user.which_profile_pic)).to eq "/rankicons/MoonBronze.png"
    expect(User.return_image_url("silver", test_user.which_profile_pic)).to eq "/rankicons/MoonSilver.png"
    expect(User.return_image_url("gold", test_user.which_profile_pic)).to eq "/rankicons/MoonGold.png"
    expect(User.return_image_url("diamond", test_user.which_profile_pic)).to eq "/rankicons/MoonDiamond.png"
    expect(User.return_image_url("master", test_user.which_profile_pic)).to eq "/rankicons/MoonMaster.png"
    
    test_user.which_profile_pic = 8
    expect(User.return_image_url("bronze", test_user.which_profile_pic)).to eq "/rankicons/SpiderBronze.png"
    expect(User.return_image_url("silver", test_user.which_profile_pic)).to eq "/rankicons/SpiderSilver.png"
    expect(User.return_image_url("gold", test_user.which_profile_pic)).to eq "/rankicons/SpiderGold.png"
    expect(User.return_image_url("diamond", test_user.which_profile_pic)).to eq "/rankicons/SpiderDiamond.png"
    expect(User.return_image_url("master", test_user.which_profile_pic)).to eq "/rankicons/SpiderMaster.png"
    
    test_user.which_profile_pic = 9
    expect(User.return_image_url("bronze", test_user.which_profile_pic)).to eq "/rankicons/VineBronze.png"
    expect(User.return_image_url("silver", test_user.which_profile_pic)).to eq "/rankicons/VineSilver.png"
    expect(User.return_image_url("gold", test_user.which_profile_pic)).to eq "/rankicons/VineGold.png"
    expect(User.return_image_url("diamond", test_user.which_profile_pic)).to eq "/rankicons/VineDiamond.png"
    expect(User.return_image_url("master", test_user.which_profile_pic)).to eq "/rankicons/VineMaster.png"
    
    test_user.which_profile_pic = 10
    expect(User.return_image_url("bronze", test_user.which_profile_pic)).to eq "/rankicons/LeafBronze.png"
    expect(User.return_image_url("silver", test_user.which_profile_pic)).to eq "/rankicons/LeafSilver.png"
    expect(User.return_image_url("gold", test_user.which_profile_pic)).to eq "/rankicons/LeafGold.png"
    expect(User.return_image_url("diamond", test_user.which_profile_pic)).to eq "/rankicons/LeafDiamond.png"
    expect(User.return_image_url("master", test_user.which_profile_pic)).to eq "/rankicons/LeafMaster.png"
    
    test_user.which_profile_pic = 11
    expect(User.return_image_url("bronze", test_user.which_profile_pic)).to eq "/rankicons/SunBronze.png"
    expect(User.return_image_url("silver", test_user.which_profile_pic)).to eq "/rankicons/SunSilver.png"
    expect(User.return_image_url("gold", test_user.which_profile_pic)).to eq "/rankicons/SunGold.png"
    expect(User.return_image_url("diamond", test_user.which_profile_pic)).to eq "/rankicons/SunDiamond.png"
    expect(User.return_image_url("master", test_user.which_profile_pic)).to eq "/rankicons/SunMaster.png"
    
    test_user.which_profile_pic = 12
    expect(User.return_image_url("bronze", test_user.which_profile_pic)).to eq "/rankicons/WindBronze.png"
    expect(User.return_image_url("silver", test_user.which_profile_pic)).to eq "/rankicons/WindSilver.png"
    expect(User.return_image_url("gold", test_user.which_profile_pic)).to eq "/rankicons/WindGold.png"
    expect(User.return_image_url("diamond", test_user.which_profile_pic)).to eq "/rankicons/WindDiamond.png"
    expect(User.return_image_url("master", test_user.which_profile_pic)).to eq "/rankicons/WindMaster.png"
  end
end
