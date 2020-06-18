class TracksController < ApplicationController
  before_action :find_tracks, only: [:show, :edit, :destroy, :update]

  def index
    @tracks = Track.all

    @tracks = Track.global_search(params[:query]) if params[:query].present?
    @tracks = @tracks.sort_by(&:date)


  end

  def show
    @track.number_of_racers = Race.where(track_id: @track.id).count
    @races = Race.where(track_id: @track.id)
    @finished_races = Race.where(status: "finished", track_id: @track.id)
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





    @markers = [{
      lat: @track.start_latitude,
      lng: @track.start_longitude,
      start_address: @track.start_address,
      infoWindow: render_to_string(partial: "info_window_start", locals: { track: @track }),
      image_url: helpers.asset_url('empty.png')
    }]

    @marker_end = {
      lat: @track.end_latitude,
      lng: @track.end_longitude,
      end_address: @track.end_address,
      infoWindow: render_to_string(partial: "info_window_end", locals: { track: @track }),
      image_url: helpers.asset_url('empty.png')
    }
    @markers << @marker_end

    # retrieving individual api race results
    if @race.present?
      if @race.status == "ongoing"
        @race = @track.races.find_by(user: current_user)
        client = Strava::Api::Client.new(
            access_token: current_user.token
        )

        activities = client.athlete_activities
        fake_activity = activities.find { |a| a.name == @race.track.name }
        activities.sort_by!(&:start_date).reverse!
        # activity = activities.first # this matchs strava_activity
        activity = activities.first unless fake_activity == activities.first
        activity ||= activities.second # this don't match

        if activity
          if fake_activity.id.to_s == @race.strava_activity_id # it will never go in this loop

            @race.strava_activity_id = activity.id.to_s
            @race.distance = activity.distance
            @race.elapsed_time = activity.elapsed_time
            @race.start_lat_lng = activity.start_latlng
            @race.end_lat_lng = activity.end_latlng
            @race.average_speed = activity.average_speed
            @race.max_speed = activity.max_speed
            if activity.distance >= fake_activity.distance
              @race.status = "finished"
            else
              @race.status = "ongoing"
            end
            @race.save

          # elsif activity.id.to_s == @race.strava_activity_id # it will never go in this loop
          #   object = pactivity

          #   @race.strava_activity_id = pactivity.id.to_s
          #   @race.distance = pactivity.distance
          #   @race.elapsed_time = pactivity.elapsed_time
          #   @race.start_lat_lng = pactivity.start_latlng
          #   @race.end_lat_lng = pactivity.end_latlng
          #   @race.average_speed = pactivity.average_speed
          #   @race.max_speed = pactivity.max_speed
          #   if pactivity.distance >= activity.distance
          #     @race.status = "finished"
          #   else
          #     @race.status = "ongoing"
          #   end
          #   @race.save

          end
        end
      end
    end

    @ongoing_races = Race.where(status: "ongoing", track_id: @track.id)
    @race = @track.races.find_by(user: current_user)
    @leaderboard = @track.races.where(status: "finished").order("elapsed_time ASC")
    @counter = 0
    @leaderboard.each do |race|
      @counter += 1
      if race == @race
        break
      end
    end
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

