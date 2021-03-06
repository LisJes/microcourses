class EventsController < ApplicationController

  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  # LIJ: Require login, but not for just viewing the home page or the course details, only for other commands listed here as create, edit, delete
  before_action :authorize_owner!, only: [:edit, :update, :destroy]
  # LIJ: Make sure that only the organizer can edit or delete his own courses
  # LIJ: ???? Documentation says use before_filter, but this is only for old Ruby versions!
  
  def index
    @events = Event.order(created_at: :desc)
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.organizer = current_user

      if @event.save
		 flash[:notice] = "Course created!"
		 redirect_to @event
	  else
		 flash.now[:alert] = "Something went wrong!"
		 render "new"
	  end
  end

  def edit
  end

  def update
	  if @event.update(event_params)
		 flash[:notice] = "Course updated"
		 redirect_to @event
	  else
         flash.now[:alert] = "Something went wrong"
		 render "edit"
	  end
  end

  def destroy
	@event.destroy
	flash[:alert] = "Course deleted"
	redirect_to events_url
  end

  private
    def set_event
      @event = Event.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:alert] = "The page you requested does not exist. Bummer"
        redirect_to events_path
    end

    #LIJ: Why is that needed? One would think that people can only submit what is in the form ;-) BUT obviously it was an issue that people would send additional parameters, also enabling them to e.g. overwrite IDs etc => restrict the parameters that one can enter
	  def event_params
		  params.require(:event).permit(:title, :description, :start_date, :end_date, :venue, :location)
	  end
	
    def authorize_owner!
      authenticate_user!
      unless @event.organizer == current_user
        flash[:alert] = "You do not have the permission to #{action_name} the #{@event.title.upcase}"
        redirect_to events_path
      end
    end
end
