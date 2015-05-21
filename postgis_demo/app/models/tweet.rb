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
#  geom         :geometry(Point,3857)
#
# see: https://github.com/phyous/twitter-geo-data

class Tweet < ActiveRecord::Base

  def self.nearby(lat: 39.2472, lng: -84.3761, count: 5)
    # Note we include * plus an artificial column for computed distance.
    # In a real app you may want to only return the columns you need and
    # skip (especially) the Geom column since it may be large (and of
    # no value to your Ruby code).
    sql = <<-SQL
      SELECT *,
        geom <-> ST_GeomFromEWKT('SRID=3857;POINT (:lng :lat)') as distance
      FROM tweets
      ORDER BY distance
      LIMIT :count;
    SQL

    # This is a safe way to include potentially unsafe parameter
    # strings in your SQL query. The AR #select method does
    # not take ? parameters like #where does, so just
    # writing the raw query like this is sometimes easier.
    # Do NOT simply include the parameters in the SQL string
    # as this can expose you to SQL injection!!
    # http://rails-sqli.org/
    Tweet.find_by_sql([sql, { lat: lat, lng: lng, count: count }])
  end

  # This is a slow way to calculate distance because
  # ST_Distance cannot use our index and will calculate the
  # distance to every Tweet in the database before finding
  # a result!
  def self.nearby_dist(lat: 39.2472, lng: -84.3761, count: 5)
    sql = <<-SQL
      SELECT *,
        ST_Distance(geom, ST_GeomFromEWKT('SRID=3857;POINT (:lng :lat)')) as distance
      FROM tweets
      ORDER BY distance ASC
      LIMIT :count;
    SQL

    Tweet.find_by_sql([sql, { lat: lat, lng: lng, count: count }])
  end


end
