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

require 'rails_helper'

RSpec.describe Tweet, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
