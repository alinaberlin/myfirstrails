require 'rails_helper'

describe ProductsController, type: :controller do
  before do
    @admin = FactoryGirl.create(:admin)
    @user = FactoryGirl.create(:user)
    @product = Product.create!(name: "race bike", price: 123)
    @product2 = Product.create!(name: "mountain bike", price: 50)
  end 
  context 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to have_http_status(200)
      expect(response).to render_template('index')
    end
  end
  context 'Edit, Delete and Create with admin user' do
    before do
      sign_in @admin
    end
    after do
      sign_out @admin
    end
    it 'should be allowed to view new product form' do
      get :new
      expect(response).to have_http_status(200)
      expect(response).to render_template('new')
    end
    it 'should be allowed to create a new product' do
      post :create, params: {product: {name: "Test", price: 100}}
      expect(response).to have_http_status(302)
    end
    it 'should failed to create a new product' do
      post :create, params: {product: {name: "Test", price: "nonumber"}}
      expect(response).to have_http_status(200)
      expect(response).to render_template('new')
    end
    it 'should be allowed to edit a product' do
      get :edit, params: { id: @product2.id }
      expect(response).to have_http_status(200)
      expect(response).to render_template('edit')
    end
    it 'should be allowed to update a product' do
      put :update, params: {  id: @product2.id,
        product: { id: @product2.id, name: @product2.name, price: @product2.price }
      }
      expect(response).to have_http_status(302)
    end
    it 'should be allowed to delete a product' do
      delete :destroy, params: { id: @product2.id }
      expect(response).to have_http_status(302)
    end
  end
  context 'Edit, Delete and Create with normal user' do
    before do
      sign_in @user
    end
    after do
      sign_out @user
    end
    it 'should not be allowed to create a new product' do
      post :create, params: {product: {name: "Test", price: 100}}
      expect(response).to have_http_status(403)
    end
    it 'should not be allowed to view new product page' do
      get :new
      expect(response).to have_http_status(403)
    end
    it 'should not be allowed to view product edit page' do
      get :edit, params: { id: @product2.id }
      expect(response).to have_http_status(403)
    end
    it 'should not be allowed to update a product' do
      put :update, params: {  id: @product2.id,
        product: { id: @product2.id, name: @product2.name, price: @product2.price }
      }
      expect(response).to have_http_status(403)
    end
    it 'should not be allowed to delete a product' do
      delete :destroy, params: { id: @product2.id }
      expect(response).to have_http_status(403)
    end
  end

end