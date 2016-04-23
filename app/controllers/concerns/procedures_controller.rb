class ProcedureController < Application Controller
  def show
    @procedures = Procedure.all
  end
end