class TracksController < ApplicationController
  before_action :find_tracks, only: [:show, :edit, :destroy, :update]

  def index
    @tracks = Track.all
    if params[:search]
      if params[:search][:query]
        @tracksresult = Track.find_by(name: params[:search][:query])
        if @tracksresult
          redirect_to tracks_path(@tracksresult)
        else
          # redirect_to action:'index', alert: "tracks not found"
          # flash.alert
          flash[:error] = 'tracks not found'
          redirect_to action:'index', danger: "tracks not found"
        end
      end
    end
  end

  def show
    @track.number_of_racers = Race.where(track_id: @track.id).count
    @races = Race.where(track_id: @track.id)
    @users = []

    @races.each do |race|
      user = User.find(race.user_id)
      @users << user
    end
    @user = current_user
    @racewithuser = Race.where(user_id:@user.id, track_id:@track.id)
    @race = @racewithuser.first


    @markers = [{
      lat: @track.start_latitude,
      lng: @track.start_longitude,
      start_address: @track.start_address,
      infoWindow: render_to_string(partial: "info_window_start", locals: { track: @track }),
      image_url: helpers.asset_url('start_line.png')
    }]

    @marker_end = {
      lat: @track.end_latitude,
      lng: @track.end_longitude,
      end_address: @track.end_address,
      infoWindow: render_to_string(partial: "info_window_end", locals: { track: @track }),
      image_url: helpers.asset_url('end_line.png')
    }
    @markers << @marker_end

  end

  def new
    @track = Track.new
  end

  def create
    @track = Track.new(tracks_params)

    if @track.save
      @chat = Chat.new(track_id: @track.id)
      @chat.save
      redirect_to track_path(@track)

    else
      render :new
    end
  end

  def edit
  end

  def update
    @tracks.update(tracks_params)

    redirect_to tracks_path
  end

  def destroy
    redirect_to root_path
    @track.destroy
  end

  private

  def find_tracks
    @track = Track.find(params[:id])
  end

  def tracks_params
    params.require(:track).permit(:name, :description, :level, :distance, :start_address, :end_address, :date, :time_to_start,:time_to_complete, :photo)
  end
end
