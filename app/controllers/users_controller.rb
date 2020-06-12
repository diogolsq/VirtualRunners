class UsersController < ApplicationController

  before_action :find_user, only: [:show]

  def index
    @users = User.all
  end

  def show

    @races = Race.where(user_id: @user.id)

    @raceopen = []
    @raceclose = []

    @races.each do |race|
      track = Track.find(race.track_id)
      if track.status == 'open'
        @raceopen << race
      else
        @raceclose << race

      end
    end
    # authorize @user

    # @markers = [{
    #   lat: @user.latitude,
    #   lng: @user.longitude,
    #   infoWindow: render_to_string(partial: "info_window", locals: { user: @user }),
    #   image_url: helpers.asset_url('logo.png')
    # }]
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
