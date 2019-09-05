class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def index
    @users = User.paginate(page: params[:page], per_page: 20).search(params[:search])
  end
  
  def show
    @first_day = Date.current
    @time_number = (1..24).to_a
  end
  
  def change_show 
    if params[:prev]
       day = params[:prev]
    elsif params[:next]
       day = params[:next]
    end  
    if day
       @first_day = day.to_date
    end
  end
  
  def create
  end
  
  def edit_info
    @user = User.find(params[:id])
  end
  
  def update_info
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "#{@user.name}の基本情報を更新しました。"
    else
      flash[:danger] = "#{@user.name}の更新は失敗しました。<br>" + @user.errors.full_messages.join("<br>")
    end
    redirect_to users_url
  end
  
  def destroy
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
