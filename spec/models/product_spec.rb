require 'rails_helper'

describe Product do
  context "when the product has comments" do
    let(:product) { Product.create!(name: "race bike", price: 123) }
    let(:user) { User.create!(email: "alina.ghetler@gmail.com", password: "berlin")}
    before do
      product.comments.create!(rating: 1, user: user, body: "Awful bike!")
      product.comments.create!(rating: 3, user: user, body: "Ok bike!")
      product.comments.create!(rating: 5, user: user, body: "Great bike!")
    end
    it "returns the average rating of all comments" do
      expect(product.average_rating).to eq 3
    end
  end
  context "Validation  works" do
    it "product is not valid" do
      expect(Product.new(description: "Nice bike")).not_to be_valid
    end
    it "price is not valid" do
      expect(Product.new(name:"bibi", price: "to")).not_to be_valid
    end      
  end
end


