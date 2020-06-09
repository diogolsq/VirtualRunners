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

  end

  def new
    @track = Track.new
  end

  def create
    @track = Track.new(tracks_params)

    if @track.save
      @chat = Chat.new(track_id:@track.id)
      @chat.save
      redirect_to track_path(@tracks)

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
