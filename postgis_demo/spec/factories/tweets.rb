# == Schema Information
#
# Table name: tweets
#
#  id           :integer          not null, primary key
#  time         :string
#  tweet_id     :string
#  language     :string
#  country_code :string
#  lat          :float
#  lng          :float
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  geom         :geometry(Point,3
#

FactoryGirl.define do
  factory :tweet do
    time "MyString"
tweet_id "MyString"
language "MyString"
country_code "MyString"
lat 1.5
lng 1.5
  end

end
