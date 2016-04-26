class ProceduresController < ApplicationController

  # route to hit
  # partial is called _procedure_index
  def index
    @procedures = Procedure.all
  end

  def show
    @procedure = Procedure.find(params[:id])
  end

end