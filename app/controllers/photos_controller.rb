class PhotosController < ApplicationController
  require 'digest'
  
  def index
    @photos = Photo.order("id desc").page(params[:page]).per(7)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photos }
    end
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    @photo = Photo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photo }
    end
  end

  # GET /photos/new
  # GET /photos/new.json
  def new
    @photo = Photo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photo }
    end
  end

  # GET /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
    respond_to do |format|
      format.html {render :layout => false}
    end
  end

  # POST /photos
  # POST /photos.json
  def create
    photo_io = params[:photo][:path]
    if photo_io 
      file_ext = File.extname(photo_io.original_filename)
      content = photo_io.read
      new_name = Digest::SHA1.hexdigest(content) + file_ext
      path = Rails.root.join('app','assets','images', new_name).to_path
      File.new(path,'w').syswrite(content)
    end
    @photo = Photo.new do |p|
      photo = params[:photo]
      p.name = photo[:name]
      p.path = new_name if new_name
      p.descrption = photo[:descrption]
    end
    respond_to do |format|
      if @photo.save
        format.html { redirect_to photos_url}
        format.json { render json: @photo, status: :created, location: @photo }
      else
        format.html { render action: "new" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /photos/1
  # PUT /photos/1.json
  def update
    @photo = Photo.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo = Photo.find(params[:id])
    File.delete(Rails.root.join("app",'assets','images',@photo.path))
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to photos_url }
      format.json { head :no_content }
    end
  end
end
