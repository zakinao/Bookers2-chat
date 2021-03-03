class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @books = @user.books.all
    @book = Book.new
    if user_signed_in?
      @currentUserRoom = UserRoom.where(user_id: current_user.id)
      @userRoom = UserRoom.where(user_id: @user.id)
      unless @user.id == current_user.id
        @currentUserRoom.each do |current|
          @userRoom.each do |user|
            if current.room_id == user.room_id
              @haveroom = true
              @roomid = current.room_id
            end
          end
        end
        unless @haveroom
          @room = Room.new
          @user_room = UserRoom.new
        end
      end
    end
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    redirect_to user_path(current_user) unless @user == current_user
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
