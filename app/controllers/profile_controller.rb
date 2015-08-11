class ProfileController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_profile

  def show
  end

  def edit
    redirect_to root_path, alert: "Yetkisiz Erişim.." unless permitted?
  end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path(@profile), notice: "Güncelleme Başarılı.."
    end
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def permitted?
    current_user == @profile.user
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :phone, :avatar )
  end
end
