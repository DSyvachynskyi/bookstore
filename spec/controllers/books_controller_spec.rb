require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:costumer) { FactoryGirl.create(:costumer) }
  let(:author) { FactoryGirl.create(:author) }
  let(:category) { FactoryGirl.create(:category) }
  let(:book) { FactoryGirl.create(:book, author: author, category: category) }
  let(:book_params) { FactoryGirl.attributes_for(:book).stringify_keys }
  
  
  before do
    create_ability!
    controller.stub(:current_costumer).and_return costumer
    request.env["HTTP_REFERER"] = "where_i_came_from"
  end

  describe 'POST #create' do
    let(:book) { FactoryGirl.build_stubbed(:book, author: author, category: category) }
    context 'with valid attributes' do
      before do
        book.stub(:save).and_return true
      end

      it 'redirects to books_path' do
        post :create, book: book_params
        expect(response).to redirect_to("#{books_path}?locale=uk")
      end

      it 'sends notice' do
        post :create, book: book_params
        expect(flash[:notice]).to have_content 'Book succesfully created!'
      end
    end

    context 'with invalid attributes' do
      before do
        Book.any_instance.stub(:save).and_return(false)
      end

      it 'redirects to back' do
        post :create, book: book_params
        expect(response).to redirect_to("where_i_came_from")
      end

      it 'sends notice' do
        post :create, book: book_params
        expect(flash[:notice]).to have_content 'Wrong filled fields!'
      end
    end

  end


end