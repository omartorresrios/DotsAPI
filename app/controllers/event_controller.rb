class EventController < ApplicationController
  before_action :authenticate_user!

  def index
    events = Event.all
    # render json: events.to_json(:methods => [event_url]), status: 200
    render :json => events.to_json(:only => [:id, :created_at, :description, :likes_count, :picture_content_type, 
         :picture_file_name, :picture_file_size, :picture_updated_at,
         :updated_at, :user_id, :video_content_type, :video_file_name,
         :video_file_size, :video_updated_at], :methods => [:event_url]), status: 200
  end

  def create
    event = current_user.events.build(event_params)
    if event.save
      render json: event, status: 201
    else
      render json: { errors: event.errors.full_messages }, status: 422
    end
  end

  private

    def event_params
      params.permit(:description, :picture)
    end
end