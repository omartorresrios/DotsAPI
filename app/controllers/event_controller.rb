class EventController < ApplicationController
  before_action :authenticate_user!

  def index
    events = Event.all.find(params[:id])#get_page(params[:page])
    render json: events, serializer: AllEventsSerializer, status: 200
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