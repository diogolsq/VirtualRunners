class UsersController < ApplicationController

  before_action :find_user, only: [:show]

  def index
    @users = User.all
  end

  def show
    # authorize @user

    # @markers = [{
    #   lat: @user.latitude,
    #   lng: @user.longitude,
    #   infoWindow: render_to_string(partial: "info_window", locals: { user: @user }),
    #   image_url: helpers.asset_url('logo.png')
    # }]
    client = Strava::Api::Client.new(
      access_token: current_user.token
    )
    @athlete = client.athlete


  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end


