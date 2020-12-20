class ToppagesController < ApplicationController
  def index
    @books = Book.order(id: :desc)
  end
end
