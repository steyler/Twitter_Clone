json.extract! tweet, :id, :content, :user_id, :like_id, :created_at, :updated_at
json.url tweet_url(tweet, format: :json)
