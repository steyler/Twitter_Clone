class LikesController < ApplicationController
    before_action :set_tweet

    def create
        @tweet.likes.build(user: current_user)
        # @tweet = Tweet.likes.build(user: current_user)

        if @tweet.save
            redirect_to root_path
        end

    end

    def update
        @tweet.likes.build(user: current_user)
        # @tweet = Tweet.likes.build(user: current_user)

        if @tweet.save
            redirect_to root_path
        end
    end

    def destroy
        # @tweet.likes.where(user)
        # @tweet.likes.destroy
    end

    def set_tweet
        @tweet = Tweet.find(params[:tweet_id])
    end

end