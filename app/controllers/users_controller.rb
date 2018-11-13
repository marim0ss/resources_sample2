class UsersController < ApplicationController

  def index
    @users = User.all
  end


  def new
    @user = User.new
  end

  def create
    @user = User.create(users_params)

    if @user

      # 新規登録時にログイン状態にする
      session[:user_id] = @user.id
      redirect_to users_path
    end
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
      # @user.idを、user_idキーとして変数sessionに代入→ブラウザにログインユーザー情報が保持される
      session[:user_id] = @user.id

      flash[:notice] = "ログインしました"


      redirect_to users_path
    else
      # バリデーションではないログイン失敗時のメッセージは自作
      @error_maessage = "無効なログインです"

      # 入力された内容をエラー出ても残す
      @email = params[:email]
      @password = params[:password]

      render("users/login_form")
    end
  end


  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end


  private
  def users_params
    params.require(:user).permit(:name, :age, :image, :email, :password)
  end
end
