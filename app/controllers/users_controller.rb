class UsersController < ApplicationController
 before_action :require_user_logged_in, only: [:index, :show, :followings, :followers]
  def index
    @user = current_user
    @users = User.order(id: :desc).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @books = Book.where(user_id: params[:id]).order(id: :desc).paginate(page: params[:page], per_page: 4)
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
   def destroy
    @book = Book.find_by(id: params[:book_id])
    @book.destroy
    @user = User.find(params[:id])
    redirect_to @user
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def likes
    @user= User.find(params[:id])
    @favorited = @user.darling.page(params[:page])
    counts(@user)
  end
  
  def userlist
    @user = User.all
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end


