require 'rails_helper'
describe User do
  context "first and last name present" do
    let(:person) { User.new(email: "alina.ghetler@gmail.com", password: "berlin", first_name: "Andrei", last_name: "Makus") }
      it "should return first name" do
        expect(person.first_name).to eq "Andrei"
      end
        it "should return last name" do
          expect(person.last_name).to eq "Makus"
        end 
      end
  context "testing validations" do
    it 'requires email address' do
      expect(User.new(first_name: "Clark", last_name: "Robbins", email: "invalidmail", password: "passwordtest")).not_to be_valid
    end
  end
end
