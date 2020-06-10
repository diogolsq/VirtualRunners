class RacesController < ApplicationController
  before_action :find_race, only: [:show, :edit, :destroy, :update]

  def show
    @user = User.find(@race.user_id)
    @track = Track.find(params[:track_id])
  end

  def create
    @user = current_user
    @track = Track.find(params[:track_id])
    @race = Race.new(user_id: @user.id, track_id: @track.id)
    @race.save
    if @race.save

      redirect_to track_path(@track, anchor: '#run'), notice: "Joined in the race"
    else
    end
  end

  def destroy
    redirect_to track_path(Track.find(params[:track_id]), anchor:'#Join'), notice: 'you no longer in the race'
    @race.destroy
  end

  private

  def find_race
    @race = Race.find(params[:id])
  end
end
