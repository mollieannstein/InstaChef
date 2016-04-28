class ProceduresController < ApplicationController

  # route to hit
  # partial is called _procedure_index
  # take sort_count_frequency off if you don't want to sort by frequency
  def index
    @procedures = Procedure.all.sort_count_frequency
      if request.xhr?
        render partial: "procedure", layout: false, locals: { procedures: @procedures }
      else
        render :index
      end
  end

  def show
    @procedure = Procedure.find(params[:id])
  end

end
