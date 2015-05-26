class NoticesController < ApplicationController
  before_action :set_notice, only: [:show, :edit, :update, :destroy]

  # GET /notices
  # GET /notices.json
  def index
    @notices = Notice.all
  end

  # GET /notices/1
  # GET /notices/1.json
  def show
    usergroups = @notice.usergroups
    found = false

    usergroups.each do |usergroup|
      unless usergroup.users.where(user_id: current_user.id).nil?
        found = true
      end
    end

    if @notice.creator == current_user || found

    else
      respond_to do |format|
        format.html { redirect_to notices_url, alert: 'You have no right to view this notice.' }
        format.json { head :no_content }
      end
    end
  end

  # GET /notices/new
  def new
    @notice = Notice.new
  end

  # GET /notices/1/edit
  def edit
    if @notice.creator == current_user

    else
      respond_to do |format|
        format.html { redirect_to notices_url, alert: 'You have no right to edit this notice.' }
        format.json { head :no_content }
      end
    end
  end

  # POST /notices
  # POST /notices.json
  def create
    @notice = Notice.new(notice_params)
    @notice.creator = current_user

    respond_to do |format|
      if @notice.save
        format.html { redirect_to @notice, notice: 'Notice was successfully created.' }
        format.json { render :show, status: :created, location: @notice }
      else
        format.html { render :new }
        format.json { render json: @notice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notices/1
  # PATCH/PUT /notices/1.json
  def update
    if @notice.creator == current_user
      respond_to do |format|
        if @notice.update(notice_params)
          format.html { redirect_to @notice, notice: 'Notice was successfully updated.' }
          format.json { render :show, status: :ok, location: @notice }
        else
          format.html { render :edit }
          format.json { render json: @notice.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to notices_path, alert: 'You have no right to update this notice.' }
        format.json { head :no_content }
      end
    end
  end

  # DELETE /notices/1
  # DELETE /notices/1.json
  def destroy
    if @notice.creator == current_user
      @notice.destroy
      respond_to do |format|
        format.html { redirect_to notices_url, notice: 'Notice was successfully deleted.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to notices_url, alert: 'You have no right to delete this notice.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notice
      @notice = Notice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notice_params
      params.require(:notice).permit(:title, :category_id, :text)
    end
end
