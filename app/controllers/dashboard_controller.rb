class DashboardController < ApplicationController

  def weight
    if request.xhr?
      render partial: "weightconverter", layout: false
    else
      render :index
    end
  end

  def fluid
    if request.xhr?
      render partial: "fluidconverter", layout: false
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
