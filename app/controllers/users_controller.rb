class UsersController < ApplicationController
  def index
    @users = User.all
    @book = Book.new
    @user = current_user  #@user = User.find(params[:id])はX、左がO
  end

  def show
    @user = User.find(params[:id])
    @books =@user.books  #@books = Book.allは全体、@user.booksで個人のデータを参照
    @book = Book.new
  end

  def edit #別のユーザー編集をクリックすると、ユーザー一覧に飛ぶ
    @user = User.find(params[:id]) #見本ではこのコードは消されている
    unless @user == current_user #unless = ～でない
      @user = current_user #左でデータを再取得、下でマイページに飛ばせる
      redirect_to  user_path(@user.id) #current_userはidの識別
    end
  end

  def update
    @user = User.find(params[:id])  #useridを識別。見本ではない、エラーあり
    if @user.update(user_params)
      flash[:notice] = 'You have updated user successfully.'
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def ensure_user #userが一致しているかどうかを以下のコードで識別、一致してないと起動
    @users = current_user.users
    @user = @users.find_by(id: params[:id])
    redirect_to user_path(@user.id) unless @user
  end

end
