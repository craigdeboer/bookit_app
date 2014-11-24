class BookingsController < ApplicationController

  before_filter :determine_bookable_item, only: [:new]

  # Route for this action for users is user_bookings_path
  def index
    if logged_in?
      @bookings = current_user.bookings.order(bookable_type: :desc, bookable_id: :asc)
    else
      redirect_to root_path
    end
  end

  def new
  	@booking = Booking.new
    session_store(params[:bookable], @bookable.id) unless session[:bookable_id]
    @bookings = @bookable.bookings.all
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @booking.start_date = params[:start_date] ? Date.parse(params[:start_date]) : nil
    @booking.end_date = params[:end_date] ? Date.parse(params[:end_date]) : nil

  end

  def create
    @bookable = session[:bookable].classify.constantize.find(session[:bookable_id])
    @booking = @bookable.bookings.new
    @booking.start_date = params[:start_date]
    @booking.end_date = params[:end_date]
    @booking.user_id = current_user.id
    session_delete
    if @booking.save
      flash[:success] = "Equipment was successfully booked"
      redirect_to root_path
    else
      redirect_to wheelchair_search_path
    end
  end

  def edit
    if params[:booking]
      @bookable = params[:booking][:bookable].classify.constantize.find(params[:booking][:id])
    else
      determine_bookable_item
    end
    @booking = @bookable.bookings.find(params[:id])
    @date = params[:date] ? Date.parse(params[:date]) : @booking.start_date
    @bookings = @bookable.bookings.all
    session[:check] = params[:booking][:check] if params[:booking]
    @proposed = Booking.new
    @proposed.start_date = params[:booking] ? Date.parse(params[:booking][:start_date]) : Date.today
    @proposed.end_date = params[:booking] ? Date.parse(params[:booking][:end_date]) : Date.today 
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update(booking_params)
    flash[:success] = "Booking date changed successfully"
    session.delete(:check)
    redirect_to user_bookings_path(current_user.id)
  end

  def destroy
    @booking = Booking.find(params[:id])
    item = @booking.bookable_type
    @booking.destroy
    flash[:success] = "The #{item} booking has been deleted."
    redirect_to user_bookings_path(current_user.id)
  end

private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

  def determine_bookable_item
    @bookable = params[:bookable].classify.constantize.find(params[bookable_id])
  end

  def bookable_id
    (params[:bookable].downcase.singularize + "_id").to_sym
  end

  def session_store(bookable_param, bookable_id)
    session[:bookable] = bookable_param
    session[:bookable_id] = bookable_id
  end

  def session_delete
    session.delete(:bookable)
    session.delete(:bookable_id)
  end





  # def start_date_formatter(params)
  #   start_date = [params['start_date(1i)'], params['start_date(2i)'], params['start_date(3i)']].join("-") 
  # end

  # def end_date_formatter(params)
  #   end_date = [params['end_date(1i)'], params['end_date(2i)'], params['end_date(3i)']].join("-") 
  # end
    



end
