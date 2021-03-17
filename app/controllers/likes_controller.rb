class LikesController < ApplicationController
    before_action :set_tweet
    before_action :set_like, only: %i[ destroy ]

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
        @like.destroy
        redirect_to root_path
    end

    def set_tweet
        @tweet = Tweet.find(params[:tweet_id])
    end

    def set_like
        @like = Like.find(params[:id])
    end

end