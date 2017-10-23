require 'rails_helper'
describe Order do
  context "create orders" do
    let(:product) { Product.create!(name: "race bike", price: 123) }
    let(:user) { User.create!(email: "alina.ghetler@gmail.com", password: "berlin")}
    let(:order) { Order.create!(user: user, product: product, total: 10) }
    it "should be created successfull" do
      expect(order.user.email).to eq user.email
    end
  end
end
