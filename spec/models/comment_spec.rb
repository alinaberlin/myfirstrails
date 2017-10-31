require 'rails_helper'

describe Comment do
  before do
    @product = Product.create!(name: "race bike", price: 123)
    @user = FactoryGirl.create(:user)
  end
  context "Create comments" do
    it "should create comment successful" do
      comment = Comment.create!(rating: 1, user: @user, body: "Awful bike!", product: @product)
      expect(comment).to be_valid 
    end
  end
  context "Comments validation" do
    it "should fail validation for missing user" do
      expect(Comment.new(rating: 1, body: "Awful bike!", product: @product)).not_to be_valid 
    end
    it "should fail validation for missing product" do
      expect(Comment.new(rating: 1, body: "Awful bike!", user: @user)).not_to be_valid 
    end
    it "should fail validation for missing rating" do
      expect(Comment.new(user: @user, body: "Awful bike!", product: @product)).not_to be_valid 
    end
    it "should fail validation for missing body" do
      expect(Comment.new(rating: 1, user: @user, product: @product)).not_to be_valid 
    end
  end
end