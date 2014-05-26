class OperationsController < ApplicationController
  def index
    @operaciones = Operation.find(:all)
    @operacion = Operation.new
    respond_to do |format|
      format.js
      format.html
    end
  end

  def new
    @operacion = Operation.new
  end

  def create
    @operacion = Operation.new(params[:operation])
    respond_to do |format|
      @operacion.oper_nombre = @operacion.oper_nombre.gsub(/\s+/, " ").strip
      if @operacion.oper_nombre == ""
        @bandera = "blank"
        format.js { render "create.js"}
      else
        if Operation.find_by_oper_nombre(@operacion.oper_nombre)
          @bandera = "exist"
          format.js { render "create.js"}
        else
          if @operacion.save
            format.html { redirect_to index_operation_path, :notice => "Registrado"}
          end
        end
      end
    end
  end

  def show
    @operacion = Operation.find(params[:id])
  end

  def eliminar
    @operacion = Operation.find(params[:id])
    respond_to do |format|
      if Construction.find_by_operation_id(@operacion.id)
        format.js { render "no_eliminar.js"}
      else
        format.js { render "eliminar.js"}
      end
    end
  end

  def destroy
    @operacion = Operation.find(params[:id])
    @operacion.destroy
    redirect_to index_operation_path
  end

  def edit
   @operacion = Operation.find(params[:id])
   respond_to do |format|
     format.js { render "edit.js"}
   end
  end

  def update
    @operacion = Operation.new(params[:operation])
    respond_to do |format|
      @operacion.oper_nombre = @operacion.oper_nombre.gsub(/\s+/, " ").strip
      if @operacion.oper_nombre == ""
        @bandera = "blank"
        format.js { render "update.js"}
      else
        if Operation.find_by_oper_nombre(@operacion.oper_nombre)
          @bandera = "exist"
          format.js { render "update.js"}
        else
          @operacion = Operation.find(params[:id])
          if @operacion.update_attributes(params[:operation])
            format.html { redirect_to index_operation_path, :notice => "Registrado"}
          end
        end
      end
    end
  end
end
