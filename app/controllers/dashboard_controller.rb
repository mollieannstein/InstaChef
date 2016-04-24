class DashboardController < ApplicationController
  def index
    @procedures = Procedure.all.sort_count_frequency
    render :index
  end
end