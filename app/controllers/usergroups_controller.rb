class UsergroupsController < ApplicationController
  before_action :set_usergroup, only: [:show, :edit, :update, :destroy, :add_user, :remove_user]
  before_action :set_user, only: [:add_user, :remove_user]

  # GET /usergroups
  # GET /usergroups.json
  def index
    @usergroups = Usergroup.all
  end

  # GET /usergroups/1
  # GET /usergroups/1.json
  def show
  end

  # GET /usergroups/new
  def new
    @usergroup = Usergroup.new
  end

  # GET /usergroups/1/edit
  def edit
  end

  # POST /usergroups
  # POST /usergroups.json
  def create
    @usergroup = Usergroup.new(usergroup_params)
    @usergroup.admin = current_user

    respond_to do |format|
      if @usergroup.save
        format.html { redirect_to @usergroup, notice: 'Usergroup was successfully created.' }
        format.json { render :show, status: :created, location: @usergroup }
      else
        format.html { render :new }
        format.json { render json: @usergroup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usergroups/1
  # PATCH/PUT /usergroups/1.json
  def update
    respond_to do |format|
      if @usergroup.update(usergroup_params)
        format.html { redirect_to @usergroup, notice: 'Usergroup was successfully updated.' }
        format.json { render :show, status: :ok, location: @usergroup }
      else
        format.html { render :edit }
        format.json { render json: @usergroup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usergroups/1
  # DELETE /usergroups/1.json
  def destroy
    @usergroup.destroy
    respond_to do |format|
      format.html { redirect_to usergroups_url, notice: 'Usergroup was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_user
    if @usergroup.admin == current_user
      unless @user.nil? || @user == current_user
        begin
          @usergroup.users.find(@user)
        rescue ActiveRecord::RecordNotFound
          @usergroup.users << @user
        end

        respond_to do |format|
          format.html { redirect_to @usergroup, notice: 'User added.' }
          format.json { head :no_content }
        end
      else
        respond_to do |format|
          format.html { redirect_to @usergroup, notice: 'Not possible to add user.' }
          format.json { head :no_content }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to @usergroup, alert: 'You have no right to add users.' }
        format.json { head :no_content }
      end
    end
  end

  def remove_user
    if @usergroup.admin == current_user
      unless @user.nil? || @user == current_user
        @usergroup.users.delete(@user)

        respond_to do |format|
          format.html { redirect_to @usergroup, notice: 'User removed.' }
          format.json { head :no_content }
        end
      else
        respond_to do |format|
          format.html { redirect_to @usergroup, notice: 'Not possible to remove user.' }
          format.json { head :no_content }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to @usergroup, alert: 'You have no right to remove users.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usergroup
      @usergroup = Usergroup.find(params[:id])
    end

    def set_user
      @user = User.where(id: params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def usergroup_params
      params.require(:usergroup).permit(:name)
    end
end
