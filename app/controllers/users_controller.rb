class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @user = current_user
    @orders = @user.orders
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      # Log the user in by setting the session user_id
      session[:user_id] = @user.id

      # Redirect to the root page or user profile
      redirect_to @user, notice: "Account created successfully."
    else
      logger.error "User creation failed: #{@user.errors.full_messages.join(', ')}"
      flash.now[:alert] = "Error creating account."
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :address, :province_id)
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    if @user.update(user_params)
      redirect_to @user, notice: "User was successfully updated."
    else
      flash.now[:alert] = "Error updating user."
      render :edit
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_path, status: :see_other, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
end
