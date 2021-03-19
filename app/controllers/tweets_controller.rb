class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[ index search ]


  # GET /tweets or /tweets.json
  def index
    #@tweets = Tweet.page
    @tweet = Tweet.new
    if(user_signed_in?)
      tweets_friends = current_user.friends.pluck(:friend_id, :user_id)
          
      if params[:search].blank?  
        @tweets = Tweet.tweets_for_me(tweets_friends).page(params[:page]).limit(49).order("id DESC")
        #@tweets = Tweet.where(user_id: current_user.id)
      else 
        @tweets = Tweet.where("content LIKE ?", "%" + params[:search] + "%").page(params[:page]).limit(49).order("id DESC") 
      end
    else 
      @tweets = Tweet.page(params[:page]).limit(49).order("id DESC") 
    end
  end

  # GET /tweets/1 or /tweets/1.json
  def show
    # tweet.likes.where(user: current_user)
    # @tweet.likes.where(user: current_user)
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  def rt
    
    @tweet = Tweet.find(params[:tweet_id])
    @tweet.retweets.build(user_id: current_user.id, content: params[:content])
   
    if @tweet.save
      redirect_to root_path
    end
  end
  
  # GET /tweets/1/edit
  def edit
  end


  # POST /tweets or /tweets.json
  def create
    @tweet = Tweet.new(tweet_params.merge(user: current_user))

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: "Tweet was successfully created." }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1 or /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: "Tweet was successfully updated." }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1 or /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: "Tweet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:content)
    end
end

class Tweet
  scope :tweet_friends, -> { where() }
end
