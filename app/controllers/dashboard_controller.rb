class DashboardController < ApplicationController
  def index
    @procedures = Procedure.all
    render :index
  end
end