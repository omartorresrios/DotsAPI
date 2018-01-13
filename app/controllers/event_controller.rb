class EventController < ApplicationController
  before_action :authenticate_user!

  def index
    events = Event.all
    # render json: events.to_json(:methods => [event_url]), status: 200
    render :json => events.to_json(:methods => [:event_url, :event_url_thumb, :user_avatar_url]), status: 200
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
      params.permit(:video, :duration)
    end
end