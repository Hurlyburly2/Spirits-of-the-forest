require 'rails_helper'

# USE ".TO EQ" AND ".TO INCLUDE" FOR ERRORS ARRAY
RSpec.describe User, type: :model do
  scenario "Required entries exist" do
    test_user = User.new(username: "", password: "", email: "")
    expect test_user.valid? == false
    
    test_user = User.new(username: "Username", password: "password", email: "")
    expect test_user.valid? == false
    
    test_user = User.new(username: "Username", password: "", email: "email@email.com")
    expect test_user.valid? == false
    
    test_user = User.new(username: "", password: "password", email: "email@email.com")
    expect test_user.valid? == false
  end
  
  scenario "Invalid Usernames are not allowed" do
    User.create(username: "NametoDup", password: "password", email: "someplace@email.com")
    test_user = User.create(username: "NametoDup", password: "password", email: "fasdkjfhak@email.com")
    expect test_user.valid? == false
    
    test_user.username = "a"
    expect test_user.valid? == false
    
    test_user.username = "fafhjkdshaflksadhflkashlhfla"
    expect test_user.valid? == false
  end
  
  scenario "Invalid emails are not allowed" do
    test_user = User.new(username: "Username", password: "password", email: "@email.com")
    expect test_user.valid? == false
    test_user = User.new(username: "Username", password: "password", email: "email@email")
    test_user = User.new(username: "Username", password: "password", email: "@")
    expect test_user.valid? == false
    
    User.create(username: "Username", password: "password", email: "email@email.com")
    test_user = User.new(username: "AnotherName", password: "password", email: "email@email.com")
    
    expect test_user.valid? == false
  end
end
