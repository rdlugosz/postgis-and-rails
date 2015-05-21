class AddIndexToTweets < ActiveRecord::Migration
  def change
    reversible do |direction|
      direction.up do
        execute <<-SQL
          CREATE INDEX idx_tweets_on_geom
          ON tweets
          USING GIST (geom);
        SQL
      end
      direction.down do
        remove_index :tweets, name: :idx_tweets_on_geom
      end
    end
  end
end
