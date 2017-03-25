class PlaylistsController < ApplicationController
  before_action :get_playlist, only: [:show]
  before_action :check_session, only: [:index]
  # before_action :playlist_access, only: [:show]

  # This is a little hacky for now. If you hit the index and have a user account
  # it redirects you to your playlist, otherwise it sends you to the sample
  # "communal" playlist until I can flesh things out a bit more.
  def index
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      redirect_to playlist_path(user.playlist)
    else
      redirect_to '/playlists/1'
    end
  end

  def show
    redirect_to root_path if @playlist.nil?
  end

  def create
    user = User.create
    @playlist = user.playlist
    if @playlist
      session[:user_id] = user.id
      render :show
    else
      flash[:error] = "An error occurred. Please try again later."
      redirect_to root_url
    end
  end

  private

  def get_playlist
    @playlist = Playlist.find_by(id: params[:id])
  end

  def check_session
    if session[:user_id]
      reset_session if User.find_by(id: session[:user_id]).nil?
    end
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
