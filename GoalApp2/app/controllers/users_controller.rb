class UsersController < ApplicationController
  def index
    @users = User.all 
    render :index
  end

  def new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["That's not right!"]
      render :new 
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
    
    render :edit
  end

  def show
    @user = User.find_by(id: params[:id])
    
    render :show
  end

private

  def user_params
    params.require(:user).permit(:username, :password)
  end



end
