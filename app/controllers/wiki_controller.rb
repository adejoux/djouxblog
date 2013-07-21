class WikiController < ApplicationController
  load_and_authorize_resource :page
  def index
  end

  def show
    @wiki =Page.wiki.find(params[:id])

    @comments = @wiki.comments.all
    @comment = @wiki.comments.build

    respond_to do |format|
      format.html # show.html.erb
      format.js
  end
end
