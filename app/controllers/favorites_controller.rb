class FavoritesController < ApplicationController
 def create
    book = Book.find(params[:book_id])
    @favorite = current_user.favorite(book)
    if @favorite.save
      flash[:success] = 'お気に入りに追加しました。'
      redirect_back(fallback_location: root_path)
    else
      @book = current_user.books.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'お気に入りの追加に失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    book = Book.find(params[:book_id])
    @favorite = current_user.unfavorite(book)
    flash[:success] = 'お気に入りを削除しました。'
    redirect_back(fallback_location: root_path)
  end
end
