class Api::V1::ReviewsController < ApplicationController

def index
end

def show
end

def create
end

def destroy
end

private

def set_review
    @review = Review.find(params[:id])
end

def review_params
    params.require(:review).permit(:body, :movie_id, :user_id)
end


end
