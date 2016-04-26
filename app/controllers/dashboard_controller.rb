class DashboardController < ApplicationController

  def temp

  end

  def conversion
    render :placeholder
  end

  def index
    @procedures = Procedure.all.sort_count_frequency
    render :index
  end
end
