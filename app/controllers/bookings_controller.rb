class BookingsController < ApplicationController

  before_filter :determine_bookable_item, except: :index

  # Route for this action for users is user_bookings_path
  def index
    @bookings = current_user.bookings.order(bookable_type: :desc, bookable_id: :asc)
  end

  def new
  	@booking = Booking.new  	
  end

  def create
    @booking = @bookable.bookings.new
    @booking.start_date = start_date_formatter(params[:booking])
    @booking.end_date = end_date_formatter(params[:booking])
    @booking.user_id = current_user.id
    if @booking.save
      flash[:success] = "Equipment was successfully booked"
      redirect_to wheelchair_bookings_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
    booking = Booking.find(params[:id])
    booking.destroy
    redirect_to wheelchair_bookings_path
  end

private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

  def determine_bookable_item
    @bookable = params[:bookable].classify.constantize.find(params[bookable_id])
  end

  def bookable_id
    (params[:bookable].singularize + "_id").to_sym
  end

  def start_date_formatter(params)
    start_date = [params['start_date(1i)'], params['start_date(2i)'], params['start_date(3i)']].join("-") 
  end

  def end_date_formatter(params)
    end_date = [params['end_date(1i)'], params['end_date(2i)'], params['end_date(3i)']].join("-") 
  end
    



end
