class InfosController < ApplicationController
  load_and_authorize_resource :page, :find_by => :permalink
  # GET /infos/1
  # GET /infos/1.json
  def show
    @info = Page.infos.published.find_by_permalink!(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @info }
    end
  end


end
