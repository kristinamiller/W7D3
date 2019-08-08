# == Schema Information
#
# Table name: users
#
#  id            :bigint           not null, primary key
#  username      :string           not null
#  pw_digest     :string           not null
#  session_token :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  
  describe User do
    let(:incomplete_user) { User.new(username: "user1")}
    let(:incomplete_user2) { User.new(password: "password")}

    # it "should validate presence of all parameters" do
    #   expect(incomplete_user).not_to be_valid
    #   expect(incomplete_user2).not_to be_valid
    # end

    it { should validate_presence_of(:username)}
    it { should validate_uniqueness_of(:username)}
    it { should validate_length_of(:password).is_at_least(6)}
    it { should validate_presence_of(:pw_digest)}

    describe 'associations' do
      it { should have_many(:goals)}
    end

    describe "User::find_by_credentials" do
      user1 = FactoryBot.create(:user)
      it "should return a user that has the same credentials" do
        expect(User.find_by_credentials(user1.username, user1.password)).to eq(user1)
      end
    end

    describe "password encryption" do
      it "should encrypt the password and store it as pw_digest" do
        expect(BCrypt::Password).to receive(:create).with("hellowhoa")
        FactoryBot.build(:user, password: "hellowhoa")
      end
    end
  end
end
