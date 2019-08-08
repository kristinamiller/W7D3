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

FactoryBot.define do
  factory :user do
    username { Faker::Name.first_name }
    password { "password" }
  end
end
