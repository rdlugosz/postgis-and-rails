class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :time
      t.string :tweet_id
      t.string :language
      t.string :country_code
      t.float :lat
      t.float :lng

      t.timestamps null: false
    end
  end
end
