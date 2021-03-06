class Profile::My::ProfilesController < Profile::My::BaseController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  
  def index
    q_params = {}
    q_params.merge! default_params
    @profiles = current_user.profiles.default_where(q_params)
  end
  
  def new
    @profile = current_user.profiles.build
    prepare_form
  end
  
  def create
    @profile = current_user.profiles.build(profile_params)
    if @profile.save
      redirect_to my_profiles_url
    else
      prepare_form
      render :new
    end
  end
  
  def show
  end

  def edit
    prepare_form
  end

  def update
    respond_to do |format|
      if @profile.update profile_params
        format.html { redirect_to my_profiles_url }
        format.js { redirect_to my_profiles_url }
        format.json { render :show }
      else
        format.html { render action: 'edit' }
      end
    end
  end
  
  def destroy
  
  end

  private
  def set_profile
    @profile = current_user.profiles.find params[:id]
  end
  
  def prepare_form
    @accounts = current_user.accounts.confirmed
  end

  def profile_params
    p = params.fetch(:profile, {}).permit(
      :real_name,
      :nick_name,
      :gender,
      :birthday_type,
      :birthday,
      :note,
      :degree,
      :major,
      :identity,
      extra: {}
    )
    p.merge! default_form_params
  end

end
