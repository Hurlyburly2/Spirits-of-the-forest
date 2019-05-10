class UsersController < ApplicationController
  def index
    @progress_bar_style = ""
    if current_user.rankup_score >= 0 && current_user.rankup_score < 100
      rank_up_percentage = current_user.rankup_score
      @progress_bar_style = "width:#{rank_up_percentage}%;background-color:#CD7F32;"
    elsif current_user.rankup_score >= 100 && current_user.rankup_score < 200
      rank_up_percentage = current_user.rankup_score - 100
      @progress_bar_style = "width:#{rank_up_percentage}%;background-color:#C0C0C0;"
    elsif current_user.rankup_score >= 200 && current_user.rankup_score < 300
      rank_up_percentage = current_user.rankup_score - 200
      @progress_bar_style = "width:#{rank_up_percentage}%;background-color:#FFD700;"
    elsif current_user.rankup_score >= 300 && current_user.rankup_score < 400
      rank_up_percentage = current_user.rankup_score - 300
      @progress_bar_style = "width:#{rank_up_percentage}%;background-color:#B9F2FF;"
    else
      @progress_bar_style = "width:100%;background-color:#ff3276;"
    end
    
    @top_ten = User.all.order(rankup_score: :desc).limit(10)
    @top_ten = @top_ten.order(:created_at)
    
    @options = [
      [true, "On"],
      [false, "Off"]
    ]
    @user = current_user
    @image_url = User.return_image_url(current_user.which_profile_pic)
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
    current_user.reminders = update_email_value
    current_user.save
    
    @progress_bar_style = ""
    if current_user.rankup_score >= 0 && current_user.rankup_score < 100
      rank_up_percentage = current_user.rankup_score
      @progress_bar_style = "width:#{rank_up_percentage}%;background-color:#CD7F32;"
    elsif current_user.rankup_score >= 100 && current_user.rankup_score < 200
      rank_up_percentage = current_user.rankup_score - 100
      @progress_bar_style = "width:#{rank_up_percentage}%;background-color:#C0C0C0;"
    elsif current_user.rankup_score >= 200 && current_user.rankup_score < 300
      rank_up_percentage = current_user.rankup_score - 200
      @progress_bar_style = "width:#{rank_up_percentage}%;background-color:#FFD700;"
    elsif current_user.rankup_score >= 300 && current_user.rankup_score < 400
      rank_up_percentage = current_user.rankup_score - 300
      @progress_bar_style = "width:#{rank_up_percentage}%;background-color:#B9F2FF;"
    else
      @progress_bar_style = "width:100%;background-color:#ff3276;"
    end
    
    @top_ten = User.all.order(rankup_score: :desc).limit(10)
    @top_ten = @top_ten.order(:created_at)
    @user = current_user
    @options = [
      [true, "On"],
      [false, "Off"]
    ]

    render :index
  end
end
