class WikiController < ApplicationController
  def index

    if params[:query]
      @pages = Page.wiki.published.text_search(params[:query]).page(params[:page]).per(5).order("created_at DESC")
      render 'search_results'
      return
    end

    if Page.wiki.published.find_by_permalink("main")
      redirect_to wiki_path("main")
    end
  end

  def show
    @page =Page.wiki.published.find_by! permalink: params[:id]

    @comments = @page.comments.all
    @comment = @page.comments.build

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end
end
