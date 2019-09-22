class BooksController < ApplicationController
	before_action :authenticate_user!
	def new
		@book = Book.new
	end
	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
		@books = Book.all
		if @book.save
			redirect_to book_path(@book.id),notice: "You have created book successfully."
		else
			render action: :index
		end
	end
	def index
		@book = Book.new
		@books = Book.all
	end
	def show
		@book = Book.new
		@detail = Book.find(params[:id])
		p @detail
	end
	def edit
		@detail = Book.find(params[:id])
		if @detail.user_id != current_user.id
			redirect_to books_path
		else
		end
	end
	def update
		@detail = Book.find(params[:id])
		if @detail.update(book_params)
			redirect_to book_path(@detail.id),notice: "You have updated book successfully."
		else
			render action: :edit
		end
	end
	def destroy
		@detail = Book.find(params[:id])
		@detail.destroy
		redirect_to books_path
	end
	private
	def book_params
		params.require(:book).permit(:title, :body)
	end
end
