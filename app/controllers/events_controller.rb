class EventsController < ApplicationController
	def new
		@event = Event.new
	end

	def create
		@event = Event.new(event_params)
		  if @event.save
		    flash[:notice] = "Course created!"
		    redirect_to @event
		  else
		  	flash.now[:alert] = "Something went wrong!"
		  	render "new"
		  end
	end

	private
	def event_params
		params.require(:event).permit(:title, :description, :start_date, :end_date, :venue, :location)
	end
end
