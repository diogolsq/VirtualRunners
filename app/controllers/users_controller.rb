class UsersController < ApplicationController

  before_action :find_user, only: [:show]

  def show
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


end
