class UsersController < ApplicationController

  def index
    @users = User.all
  end


  def new
    @user = User.new
  end

  def create
    User.create(users_params)
    redirect_to users_path
  end



  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(users_params)
    redirect_to users_path
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path
  end


  # ログインページ
  def login_form

  end

  # ログイン処理
  def login
    @user = User.find_by(email: params[:email],
                          password: params[:password])
    if @user
      redirect_to users_path # ログインできたら
    else
      # バリデーションではないログイン失敗時のメッセージは自作
      @error_maessage = "無効なログインです"

      # 入力された内容をエラー出ても残す
      @email = params[:email]
      @password = params[:password]

      render("users/login_form")
    end
  end

  private
  def users_params
    params.require(:user).permit(:name, :age, :image, :email, :password)
  end
end
