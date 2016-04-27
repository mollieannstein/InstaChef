class DashboardController < ApplicationController

  def temp
  end

  def conversion
    if request.xhr?
      render partial: "converter", layout: false
    else
      render :index
    end
  end

  def index
    @procedures = Procedure.all.sort_count_frequency
    if request.xhr?
      render :index
    else
      render :index
    end
  end
end
