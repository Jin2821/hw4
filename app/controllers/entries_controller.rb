class EntriesController < ApplicationController
  def index
    @entries = Entry.all

    respond_to do |format|
      format.html
      format.json do
        render :json => @entries
      end
    end
  end

  def new
    @user = User.find_by({ "id" => session["user_id"] })
  end

  def create
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil
      @entry = Entry.new
      @entry["title"] = params["title"]
      @entry["occurred_on"] = params["occurred_on"]
      @entry.uploaded_image.attach(params["uploaded_image"])
      @entry["description"] = params["description"]
      @entry["place_id"] = params["place_id"]
      @entry["user_id"] = @user["id"]
      @entry.save
    else
      flash["notice"] = "Login first."
    end
    redirect_to "/entries"
  end

 
end