class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    if user_signed_in?
      if current_user.profile == nil 
        current_user.profile = Profile.create(full_name:"", user_type: current_user.email == "admin@rp.com" ? 357168 : 0)
        current_user.save
      end
      @profile = current_user.profile
      
      case @profile.user_type
        when 357168 #Admin 
          
        when 3396 #Employer
          
        when 445 #Employee
          redirect_to employee_url(@profile.employee.id)
        when 2623 #Vendor
          redirect_to vendor_url(@profile.vendor.id)
        else
          puts "Wrong type"
        end

    else
      redirect_to job_posts_url
    end
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)

    @user = User.new(:email => params[:profile][:email], :password => params[:profile][:password], :password_confirmation => params[:profile][:password])
    if @user.save
      puts "USER created"
    else
      puts "USER NOT created" + @user.errors.messages.to_s
      format.html { render :new }
    end

    @profile.user = @user

    respond_to do |format|
      if @profile.save

        case params[:profile][:user_type].to_i
        when 357168 #Admin 
          puts "Admin Not Created"
        when 3396 #Employer
          puts "Employer Not Created"
        when 445 #Employee
          @employee = Employee.create()
          @employee.profile = @profile

          if @employee.save 
            puts "Employee Created"
          else
            puts "Employee NOT created" + @employee.errors.messages.to_s
          end

        when 2623 #Vendor
          
          @vendor = Vendor.create()
          @vendor.profile = @profile

          if @vendor.save 
            puts "Vendor Created"
          else
            puts "Vendor NOT created" + @employee.errors.messages.to_s
          end

        else
          puts "Other Not Created" + params[:profile][:user_type].to_s
        end

        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      if params[:id] != nil
        @profile = Profile.find(params[:id])
      end
    end

    # Only allow a list of trusted parameters through.
    def profile_params
      params.require(:profile).permit(:full_name, :user_type, :email, :password)
    end
end
