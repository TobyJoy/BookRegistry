require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe 'GET #index' do
    before(:each) do
      @book = create(:book)
    end
    
    it "returns http success" do
      get :index
      expect(response).to render_template :index
    end 
  end
  
end
