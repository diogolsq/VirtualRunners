class RacesController < ApplicationController
  require 'dotenv/load'
  require 'strava-ruby-client'
  require 'webrick'

  before_action :find_race, only: [:show, :edit, :destroy, :update]

  def show
    @user = User.find(@race.user_id)
    @track = Track.find(params[:track_id])
  end

  def create
    @user = current_user
    @track = Track.find(params[:track_id])
    @race = Race.new(user_id: @user.id, track_id: @track.id)
    if @race.save
      redirect_to track_path(@track), notice: "Joined in the race"
    end
  end

  def destroy
    redirect_to root_path, notice: 'you no longer in the race'
    @race.destroy
  end

def start_running
    @race = current_user.races.find(params[:id])

    client = Strava::Api::Client.new(
      access_token: current_user.token
    )
    activity = client.create_activity(
      name: @race.track.name,
      type: 'Run',
      start_date_local: Time.now,
      elapsed_time: 0, # in seconds
      description: @race.track.description,
      distance: (@race.track.distance * 1000) # in meters
    )
    @race.update(strava_activity_id: activity.id.to_s)

    redirect_to @race.track

end

def finished_running
  @race = current_user.races.find(params[:id])

  client = Strava::Api::Client.new(
      access_token: current_user.token
    )
  activities = client.athlete_activities

  activity = activities.first
  pactivity = activities[1]

  binding.pry

  if pactivity.id.to_s == @race.id
    @race.strava_activity_id = activity.strava_activity_id.to_s
    @race.distance = activity.distance
    @race.elapsed_time = activity.elapsed_time
    @race.start_lat_lng = activity.start_latlng
    @race.end_lat_lng = activity.end_latlng
    @race.average_speed = activity.average_speed
    @race.max_speed = activity.max_speed
    if activity.distance >= pactivity.distance
      @race.status = "finished"
    else
      @race.status = "Distance not completed"
    end
  end
end

=begin
  def create_webhook
    @track = Track.find(params[:id])
    logger = ::Logger.new(STDOUT)
    logger.level = Logger::INFO

    client = Strava::Webhooks::Client.new(
      client_id: ENV['STRAVA_CLIENT_ID'],
      client_secret: ENV['STRAVA_CLIENT_SECRET'],
      logger: logger
    )
      callback_url = "https://d9f5f1cebbb3.ngrok.io/races/strava_api"
      raise 'Missing callback_url.' unless callback_url

      client.logger.info "Subscribing to #{callback_url} ..."
      subscription = client.create_push_subscription(callback_url: callback_url, verify_token: "STRAVA")
  end
=end

  private

  def find_race
    @race = Race.find(params[:id])
  end
end
