class AddTriggerToTweets < ActiveRecord::Migration
  def change
    reversible do |direction|
      direction.up do
        execute <<-SQL
CREATE FUNCTION update_tweet_geom() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
        BEGIN
          NEW.geom := ST_GeomFromEWKT('SRID=3857;POINT (' || NEW.lng || ' ' || NEW.lat || ')');
          RETURN NEW;
        END;
      $$;

CREATE TRIGGER trigger_update_geom_on_tweet_update BEFORE INSERT OR UPDATE ON tweets FOR EACH ROW EXECUTE PROCEDURE update_tweet_geom();

SQL
      end
      direction.down do
        execute <<-SQL
        DROP TRIGGER trigger_update_geom_on_tweet_update ON tweets;
        DROP FUNCTION update_tweet_geom();
        SQL
      end
    end
  end
end
