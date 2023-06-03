class BooksController < ApplicationController


  def index
    @books = Book.all
    @book = Book.new
    @users = User.all
    @user = current_user
  end #@user2が悪さしている

  def show
    @book = Book.new #@book 2つがあるせいで新規投稿欄にデータ。
    @bookf = Book.find(params[:id]) #弄れるのはこっち?(元は@book)
    @user = @bookf.user  #@user = User.find(params[:id])はX 左がO
  end #@bookfでデータを選択、@userの情報を@bookfから取得
      #一覧をそれぞれのデータで表示するには@user系列でもう一つ指示がいる？


  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = 'You have created book successfully.'
      redirect_to book_path(@book)
    else
      #@books で必要な情報を取得　render :index　だけではerrorが起きる
      @books = Book.all
      @user = current_user  #左の情報がないとエラーが起きる
      render :index
    end

  end


  def edit
    @book = Book.find(params[:id])
    unless @book.user == current_user #unless = ～でない
      redirect_to  books_path #current_userはidの識別
    end
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = 'You have updated book successfully.'
      redirect_to book_path(@book)  #@付けた5,18,14
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit( :title, :body)
  end

end
