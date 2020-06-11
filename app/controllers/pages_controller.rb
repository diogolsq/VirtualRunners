class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home

    if params[:query].present?
      @tracks = Track.global_search(params[:query])
    else
      @tracks = Track.all
    end
  end
end
