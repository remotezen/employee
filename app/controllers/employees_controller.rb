class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show]
  def index
    @employees = User.all
  end

  def show
  end

  private

  def set_employee
    @employee = User.find(params[:id])
  end

end
