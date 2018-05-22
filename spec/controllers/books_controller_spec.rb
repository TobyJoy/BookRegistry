require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = create(:user)
    sign_in user
    @book = create(:book)
  end
  
  describe 'GET #new' do
    
    before :each do
      allow(Book).to receive(:new).and_return(@book)
      get :new
    end
    
    it "returns http success" do
      expect(response).to render_template :new
      expect(response).to be_success
      expect(assigns(:book)).to eq(@book)
      expect(response).to render_template("new")
    end 
  end
  
  describe "POST #create" do
    context "for valid resource" do
      before do
        post :create, :params => { book: attributes_for(:book) }
      end
      
      subject {assigns("book")}
      it {expect(response).to redirect_to books_url}
    end
    
    context "for Invalid resource" do
      before do
        post :create, :params => { book: {name: nil} }
      end
    
      it {is_expected.to render_template :new}
      subject {assigns("book")}
      it "returns with an error message" do
        expect(assigns(:book).errors.full_messages.join).to match /can't be blank/ 
      end
    end 
  end
  
  describe 'GET #edit' do
    
    before :each do
      @found_book = Book.first
      get :edit, params: { :id => @found_book.id}
    end
    
    it "returns http success" do
      expect(response).to render_template :edit
      expect(response).to be_success
      expect(assigns(:book)).to eq(@found_book)
    end 
  end
  
  describe "PUT update/:id" do
    before(:each) do
      @found_book = Book.first
    end

    context "for valid resource" do
      let(:attr) do 
        { :book_name => 'new title' }
      end
    
      before(:each) do
        put :update, params: { :id => @found_book.id, :book => attr }
        @found_book.reload
      end
    
      it { expect(response).to redirect_to(books_url) }
      it { expect(@found_book.book_name).to eql attr[:book_name] }
    end
    
    context "for Invalid resource" do
      let(:attr) do 
        { :book_name => nil }
      end
      
      before(:each) do
        put :update, params: {:id => @found_book.id, :book => attr}
        @found_book.reload
      end
    
      it {is_expected.to render_template :edit}
      it "returns with an error message" do
        expect(assigns(:book).errors.full_messages.join).to match /can't be blank/ 
      end
    end 
  end
  
  describe "PATCH update/:id" do   
    let(:attr) do 
      { :publish_status => true }
    end
  
    before(:each) do
      @found_book = Book.first
      put :update, params: { :id => @found_book.id, :book => attr }
      @found_book.reload
    end
  
    it { expect(response).to redirect_to(books_url) }
    it { expect(@found_book.publish_status).to eql attr[:publish_status] }
  end
  
  
  describe "DELETE destroy/:id" do
    before(:each) do
      @found_book = Book.first
      expect { delete :destroy, params: {:id => @found_book.id}}.to change(Book, :count).by(-1)
    end
    
    it {expect(response).to redirect_to books_url}
  end

end
