class Api::V1::MoviesController < ApplicationController
    skip_before action authenticate, only:[:index,:show]
    before_action :set_movie, only: [:show,:update,:destroy]

    #get all
    def index
        @movies = Movie.all
        render json:@movies
    end

    #Get 1 
    #movie/1
    def show
        @reviews = Review.where(movie_id: params[:id])
        render json:{movie:@movie, reviews:@reviews}
    end

    #Post
    def create
        @movie = Movie.new(movie_params)
        if @movie.save
            render json:@movie
        else
            render json: @movie.errors, status: :unprocessable_entity
        end
    end

    # Put/Patch
    def update
        if @movie.update(movie_params)
            render json: @movie
        else
            render json: @movie.errors, status: :unprocessable_entity
        end
    end

    #Delete
    def destroy
        @movie.destroy
    end
    
    def get_upload_credentials
        @accessKey = ENV['S3_ACCESS']
        @secretKey = ENV['S3_SECRET']
        render json: { accessKey: @accessKey, secretKey: @secretKey}
    end

    private

    def set_movie
        @movie = Movie.find(params[:id])
    end

    def movie_params
        params.require(:movie).permit(:title, :description, :parental_rating, :year,:total_gross, :duration, :image, :cast, :id)
    end

end
