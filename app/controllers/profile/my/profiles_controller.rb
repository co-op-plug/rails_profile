class Profile::My::ProfilesController < Profile::My::BaseController
  before_action :set_profile

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @profile.update profile_params
        format.html { redirect_to my_profile_url }
        format.json { render :show }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  private
  def set_profile
    @profile = current_user.profile || current_user.create_profile
  end

  def profile_params
    params.fetch(:profile, {}).permit(
      :real_name,
      :nick_name,
      :gender,
      :birthday_type,
      :birthday,
      :note,
      :degree,
      :major
    )
  end

end
