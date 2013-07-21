class PagesController < ApplicationController
  load_and_authorize_resource
  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.text_search(params[:query]).page(params[:page]).per(5).order("created_at DESC")

    if not_admin?
      @pages=@pages.published
    end

    if params[:tag]
      @pages = @pages.tagged_with(params[:tag])
    end

    if params[:category]
      case params[:category]
        when "wiki" then @pages = @pages.wiki
        when "posts" then @pages =  @pages.posts
        when "info" then @pages = @pages.info
        else @pages =@pages.posts
      end
    elsif not_admin?
      @pages =@pages.posts
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    if params[:category]
      case params[:category]
        when "wiki" then @page =Page.wiki.find(params[:id])
        when "posts" then @page =Page.posts.find(params[:id])
        when "info" then @page =Page.info.find(params[:id])
        else @page =Page.posts.find(params[:id])
      end
    else
      @page = Page.find(params[:id])
    end

    @comments = @page.comments.all
    @comment = @page.comments.build

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

  def add_comment
    @page = Page.find(params[:id])
    @comment = @page.comments.build
    respond_to do |format|
      format.js
    end
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    @page = Page.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(params[:page])
    @page.author=current_user.name

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    @page = Page.find(params[:id])
    @page.author=current_user.name

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end


end
