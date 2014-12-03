class BookingsController < ApplicationController

  before_action :require_login
  before_filter :determine_bookable_item, only: [:new]

  def index
    if logged_in?
      @bookings = current_user.bookings.where("end_date >= ?", Date.today).order(bookable_type: :desc, start_date: :asc)
    else
      redirect_to root_path
    end
  end

  def new
  	@booking = Booking.new
    session_delete if params[:bookable] && session[:bookable] #Clears the session variables if user exited an earlier new booking process without creating it
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
      @bookable = determine_bookable_item
      session.delete(:check) unless params[:date]
    end
    @booking = Booking.find(params[:id])
    @date = params[:date] ? Date.parse(params[:date]) : @booking.start_date
    @bookings = @bookable.bookings.all
    session[:check] = params[:booking][:check] if params[:booking]
    @proposed = Booking.new
    @proposed.start_date = params[:booking] ? Date.parse(params[:booking][:start_date]) : nil
    @proposed.end_date = params[:booking] ? Date.parse(params[:booking][:end_date]) : nil
    if params[:date]
      @proposed.start_date = params[:start_date]
      @proposed.end_date = params[:end_date]
    end
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
    @booking.destroy
    flash[:success] = "The booking has been deleted."
    redirect_to user_bookings_path(current_user.id)
  end

private

  def require_login
    unless logged_in?
      flash[:info] = "You must be logged in to visit this page. Please log in."
      redirect_to login_path
    end
  end

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





  


end
