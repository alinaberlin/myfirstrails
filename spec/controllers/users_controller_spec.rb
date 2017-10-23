require 'rails_helper'

describe UsersController, type: :controller do
  let(:user) { User.create!(email: 'peter@example.com', password: '1234567890') }
  let(:user1) { User.create!(email: 'peter1@example.com', password: '125664567890') }
  describe 'GET #show' do
    context 'when a user is logged in' do
      before do
        sign_in user
      end
      it "loads correct user details" do
        get :show, params: { id: user.id }
        expect(response).to have_http_status(200)
        expect(assigns(:user)).to eq user
      end
      it 'redirects to index page' do
        get :show, params: { id: user1.id }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to('/')
      end
    end
  
    context 'when a user is not logged in' do
      it 'redirects to login' do
        get :show, params: { id: user.id }
        expect(response).to redirect_to('/')
      end
    end
  end
end