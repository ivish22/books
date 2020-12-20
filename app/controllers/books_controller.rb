class BooksController < ApplicationController
  before_action :set_book, only: [:show, :destroy, :update]
  
  def index
    search
    @user = current_user
    counts(@user)
  end

  def show
    @user = current_user
    
  end

  def new
    @book = Book.new
    @user = current_user
  end

  def edit
    @book = Book.find(params[:book_id])
    @user = User.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    @book = current_user.books.build(book_params)
      if @book.save
        flash[:success] = '感想を投稿しました。'
      redirect_to books_url
      else
       @microposts = current_user.microposts.order(id: :desc).page(params[:page])
      flash.now[:danger] = '感想の投稿に失敗しました。'
      render 'toppages/index'
      end
  end


  def update
      @user = current_user
      if @book.update(book_params)
       redirect_to @book
      else
        
      end
  end

  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:name, :author, :content, :user_id, :image)
    end
    
    def search
      @books = Book.search(params[:search]).order(id: :desc).paginate(page: params[:page], per_page: 4)
    end
end
