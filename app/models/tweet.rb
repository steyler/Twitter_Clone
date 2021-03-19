# == Schema Information
#
# Table name: tweets
#
#  id         :bigint           not null, primary key
#  content    :text
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :retweets, class_name: "Tweet", foreign_key: "retweet_id"
  belongs_to :retweet, class_name: "Tweet", optional: true

  scope :tweets_for_me, -> (tweets_friends) { where( user_id: tweets_friends) }  

  validates :content, presence: true

  # Self hace referencia al lugar donde estamos situados
  def content_with_hashtag
    new_content = self.content.split(' ').map do |word|
      
      if word.include?('#')
        "<a href='/?search=#{word}'>##{word}</a>"
      else
        word
      end
    end
    new_content.join(' ').html_safe
  end

end
