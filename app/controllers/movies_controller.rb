class MoviesController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_record_response
  # wrap_parameters false
  
  def index
    movies = Movie.all
    render json: movies
  end

  def create
    movie = Movie.create(movie_params)
    render json: movie, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  private

  # def render_invalid_record_response(invalid)
  #   render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
  # end

  def movie_params
    params.permit(:title, :year, :length, :director, :description, :poster_url, :category, :discount, :female_director)
  end
  
end
