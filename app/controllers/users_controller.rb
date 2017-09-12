class UsersController < ApplicationController
  check_authorization
  def show
    @user = User.find(params[:id])
  end
end
