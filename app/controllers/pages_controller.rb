class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @tracks = Track.all


    if params[:query].present?
      @products = Track.global_search(params[:query])
    else
      @tracks = Track.all
    end

  end
end
