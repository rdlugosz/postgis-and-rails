class AddGeomToTweets < ActiveRecord::Migration
  def change
    reversible do |direction|
      direction.up do
        execute <<-SQL
          ALTER TABLE tweets
          ADD COLUMN geom GEOMETRY(Point, 3857);
        SQL
      end
      direction.down do
        remove_column :tweets, :geom
      end
    end
  end
end
