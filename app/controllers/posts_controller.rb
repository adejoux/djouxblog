class PostsController < ApplicationController
  def index
    @pages = Page.posts.text_search(params[:query]).page(params[:page]).per(5).order("publish_at DESC")

    if not_admin?
      @pages=@pages.published
    end

    if params[:tag]
      @pages = @pages.tagged_with(params[:tag])
    end

  end

  def show
    @page =Page.posts.find_by! permalink: params[:id]

    @comments = @page.comments.all
    @comment = @page.comments.build

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end
end
