class InfosController < ApplicationController
  # GET /infos/1
  # GET /infos/1.json
  def show
    @page = Page.infos.published.find_by! permalink: params[:id]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end


end
