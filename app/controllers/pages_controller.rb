class PagesController < ApplicationController
  load_and_authorize_resource :find_by => :permalink
  # GET /pages
  # GET /pages.json
  def index
    if not_admin?
      redirect_to root_path
      return
    end

    @pages = Page.text_search(params[:query]).kpage(params[:kpage]).per(10).order("publish_at DESC")

    if params[:tag]
      @pages = @pages.tagged_with(params[:tag])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    if not_admin?
      redirect_to root_path
      return
    end
    @page = Page.find_by! permalink: params[:id]
    @comments = @page.comments.all
    @comment = @page.comments.build

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

  def add_comment
    @page = Page.find_by! permalink: params[:id]
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
    @page = Page.find_by! permalink: params[:id]
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(page_params)
    @page.user_id=current_user.id
    @page.permalink=@page.title.parameterize

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
    @page = Page.find_by! permalink: params[:id]
    params[:page][:permalink]=params[:page][:title].parameterize

    respond_to do |format|
      if @page.update_attributes(page_params)
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
    @page = Page.find_by! permalink: params[:id]
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end

  private
  def page_params
    params.require(:page).permit(:user_id, :content, :title, :summary, :tag_list, :publish_at, :category, :permalink, :parent_id)
  end
end
