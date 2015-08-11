class UsersController < ApplicationController
  def index
  	@users = User.all
  end

  def destroy
  	if current_user.roles.first == Role.first
  		@user = User.find(params[:id])
  		@user.destroy
  		redirect_to root_path
  	else
  		redirect_to root_path ,  alert: "Yetkisiz Erişim."
  	end
  end

end
