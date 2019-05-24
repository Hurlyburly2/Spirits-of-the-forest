class UsersController < ApplicationController
  def index
    @progress_bar_style = ""
    @progress_bar_style = User.get_progress_bar_style(current_user.rankup_score)
    
    @top_ten = User.all.order(rankup_score: :desc).limit(10)
    @top_ten = @top_ten.order(:created_at)
    
    @options = [
      [true, "On"],
      [false, "Off"]
    ]
    @user = current_user
    @image_url = User.return_image_url(current_user.rank, current_user.which_profile_pic)
    
    @profile_image_collection = User.profile_image_collection
    binding.pry
    @default_pic = @profile_image_collection[(current_user.which_profile_pic) - 1]
    
  end
  
  def update
    update_email_value = params["user"]["reminders"]
    if update_email_value === "false"
      update_email_value = false
      flash.now[:sad] = "Notifications Turned Off"
    else
      update_email_value = true
      flash.now[:sad] = "Notifications Turned On"
    end
    
    @profile_pic_num = 1
    @default_pic = ""
    case params["user"]["which_profile_pic"]
      when "Branch"
        @profile_pic_num = 1
        @default_pic = "Branch"
      when "Dew"
        @profile_pic_num = 2
        @default_pic = "Dew"
      when "Flower"
        @profile_pic_num = 3
        @default_pic = "Flower"
      when "Fruit"
        @profile_pic_num = 4
        @default_pic = "Fruit"
      when "Moss"
        @profile_pic_num = 5
        @default_pic = "Moss"
      when "Mushroom"
        @profile_pic_num = 6
        @default_pic = "Mushroom"
      when "Moon"
        @profile_pic_num = 7
        @default_pic = "Moon"
      when "Spider"
        @profile_pic_num = 8
        @default_pic = "Spider"
      when "Vine"
        @profile_pic_num = 9
        @default_pic = "Vine"
      when "Leaf"
        @profile_pic_num = 10
        @default_pic = "Leaf"
      when "Sun"
        @profile_pic_num = 11
        @default_pic = "Sun"
      when "Wind"
        @profile_pic_num = 12
        @default_pic = "Wind"
    end

    current_user.which_profile_pic = @profile_pic_num
    current_user.reminders = update_email_value
    current_user.save
    
    @progress_bar_style = ""
    @progress_bar_style = User.get_progress_bar_style(current_user.rankup_score)
    
    @top_ten = User.all.order(rankup_score: :desc).limit(10)
    @top_ten = @top_ten.order(:created_at)
    @user = current_user
    @options = [
      [true, "On"],
      [false, "Off"]
    ]
    
    @image_url = User.return_image_url(current_user.rank, current_user.which_profile_pic)
    
    @profile_image_collection = User.profile_image_collection
    @default_pic = @profile_image_collection[(current_user.which_profile_pic) - 1]
    render :index
  end
end
