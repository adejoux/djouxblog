class VersionsController < ApplicationController
  load_and_authorize_resource
  def show
    @version = Version.find(params[:id])
    @page = @version.reify

    respond_to do |format|
      format.html
    end
  end

  def revert
    @version = Version.find(params[:id])
    @version.reify.save!
    redirect_to page_path(@version.reify), :notice => "Undid #{@version.event}"
  end

  def edit
    @version = Version.find(params[:id])
    @page = @version.reify

    respond_to do |format|
      format.html
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @version = Version.find(params[:id])
    @version.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
end
