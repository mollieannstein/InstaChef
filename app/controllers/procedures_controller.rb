class ProceduresController < ApplicationController

  def show
    @procedure = Procedure.find(params[:id])
  end

end