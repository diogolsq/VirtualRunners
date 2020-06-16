class TracksController < ApplicationController
  before_action :find_tracks, only: [:show, :edit, :destroy, :update]

  def index
    @tracks = Track.all
    @tracks = @tracks.sort_by(&:date)

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
    @finished_races = Race.where(status: "finished", track_id: @track.id)
    @ongoing_races = Race.where(status: "ongoing", track_id: @track.id)
    @users = []
    @race = @track.races.find_by(user: current_user)
    @date = DateTime.new(@track.date.year, @track.date.month, @track.date.day, @track.time_to_start.hour, @track.time_to_start.min, @track.time_to_start.sec)
    @races.each do |race|
      user = User.find(race.user_id)
      @users << user
    end
    @user = current_user
    @racewithuser = Race.where(user_id:@user.id, track_id:@track.id)
    @race = @racewithuser.first
    @leaderboard = @track.races.where(status: "finished").order("elapsed_time ASC")


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

    # retrieving individual api race results
    find_user_race if @race.present?

    @race = @track.races.find_by(user: current_user)
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

  def find_user_race
    @race = @track.races.find_by(user: current_user)
    client = Strava::Api::Client.new(
        access_token: current_user.token
    )

    activities = client.athlete_activities
    activity = activities.first
    pactivity = activities[1]

    if pactivity
      if pactivity.id.to_s == @race.strava_activity_id
        @race.strava_activity_id = activity.id.to_s
        @race.distance = activity.distance
        @race.elapsed_time = activity.elapsed_time
        @race.start_lat_lng = activity.start_latlng
        @race.end_lat_lng = activity.end_latlng
        @race.average_speed = activity.average_speed
        @race.max_speed = activity.max_speed
        if activity.distance >= pactivity.distance
          @race.status = "finished"
        else
          @race.status = "ongoing"
        end
      end
    end
  end

  def find_tracks
    @track = Track.find(params[:id])
  end

  def tracks_params
    params.require(:track).permit(:name, :description, :level, :distance, :start_address, :end_address, :date, :time_to_start,:time_to_complete, :photo)
  end
end

