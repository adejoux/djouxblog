class WikiController < ApplicationController
  load_and_authorize_resource :page
  def index
    if Page.wiki.published.find_by_permalink("main")
      redirect_to wiki_path("main")
    end
  end

  def show
    @wiki =Page.wiki.published.find_by_permalink!(params[:id])

    @comments = @wiki.comments.all
    @comment = @wiki.comments.build

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end
end
