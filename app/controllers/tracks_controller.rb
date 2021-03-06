  class TracksController < ApplicationController
  before_action :set_track, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user
  
  # GET /tracks
  # GET /tracks.json
  def index
    @tracks = Track.all
   
    if params[:search]
        @tracks = Track.search(params[:search]).order("created_at DESC")
      else
        @tracks = Track.all.order('created_at DESC')
    end


  #  @albumnames = Hash.new("single")                # create new hash for collect list of Album_names and track_id #вместо nill будет возващяться single
  #  @tracks.each do |track|
  #    unless track.album_id               # if Album_names is empty we put "single"
  #      @albumnames[track.id] = "single"
  #    else
  #      @albumnames[track.id] = Album.find(track.album_id).album_name
  #    end
  #  end  
  # albumnames = @albumnames.select{|k,v| k == track.id}.values   #select album name by "trak's id" and leaves only values
  #

  end

  # GET /tracks/1
  # GET /tracks/1.json
  def show
      unless @track.album_id  
      @album_name = "\"Don't assigned or doesn't belong to any album \""
    else
      @album_name = Album.find(@track.album_id).album_name
    end
  end

  # GET /tracks/new
  def new
    @track = Track.new
  end

  # GET /tracks/1/edit
  def edit
  end

  # POST /tracks
  # POST /tracks.json
  def create
    @track = Track.new(track_params)

    respond_to do |format|
      if @track.save
        format.html { redirect_to @track, notice: 'Track was successfully created.' }
        format.json { render action: 'show', status: :created, location: @track }
      else
        format.html { render action: 'new' }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tracks/1
  # PATCH/PUT /tracks/1.json
  def update
    respond_to do |format|
      if @track.update(track_params)
        format.html { redirect_to @track, notice: 'Track was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tracks/1
  # DELETE /tracks/1.json
  def destroy
    @track.destroy
    respond_to do |format|
      format.html { redirect_to tracks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_track
      @track = Track.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def track_params
      params.require(:track).permit(:record_name, :autor_name, :album_id, :user_id)
    end
end
