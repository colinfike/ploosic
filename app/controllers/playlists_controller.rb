class PlaylistsController < ApplicationController
  before_action :get_playlist, only: [:show]
  # before_action :playlist_access, only: [:show]

  def index
    # redirect_to '/playlists/1'
  end

  def show
  end

  def create
    user = User.create
    @playlist = user.playlist
    if @playlist
      session[:user_id] = user.id
      render :show
    else
      flash[:error] = "Please try again later"
      redirect_to root_url
    end
  end

  private

  def get_playlist
    @playlist = Playlist.find_by(id: params[:id])
  end

  # TODO: Update this for private playlists
  # def playlist_access
  #   if session[:user_id]
  #     user = User.find_by(id: session[:user_id])
  #     false if user.playlist.id != params[:id]
  #   else
  #     false
  #   end
  # end
end
