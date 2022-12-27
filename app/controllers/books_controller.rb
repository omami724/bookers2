class BooksController < ApplicationController
  
  def new
    @book = Book.new
  end
  
  def top
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice]="You have creatad book successfully."
      redirect_to book_path(@book)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end
  
  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
    
  end

  def show
    @book = Book.find(params[:id])
    @newbook = Book.new
    @user = @book.user
    
  end
  
  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      flash[:notice]="Book was successfully destroyed."
      redirect_to books_path
    end
  end
  
  def edit
   @book = Book.find(params[:id])
    if @book.user == current_user
        render "edit"
    else
        redirect_to books_path
    end
  end

  
  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
