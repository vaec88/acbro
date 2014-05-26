class HonorariesController < ApplicationController
  def index
    inmuebles_current = Construction.joins(:personas=>:users).where(:personas_roles_users=>{:role_id=>"2",:user_id=>current_user}, :personas_constructions_roles=>{:construction_id => params[:construction_id]}).uniq
    if (current_user and current_user.id == 1) or (current_user and inmuebles_current.exists? and inmuebles_current.find(params[:construction_id]))
      @honorarios = Honorary.where(:construction_id => params[:construction_id])
      @inmueble = Construction.find(params[:construction_id])
      @honorario = Honorary.new
      respond_to do |format|
        format.js
        format.html
      end
    else
      redirect_to denegado_path
    end
  end

  def new
    @honorario = Honorary.new
    @inmueble = Construction.find(params[:construction_id])
  end

  def create
    @honorario = Honorary.new(params[:honorary])
    @bandera = ""
    @hon_cantidad = ""
    @hon_fecha = ""

    respond_to do |format|
      if (@honorario.hon_cantidad == nil) or (@honorario.hon_fecha == nil)
        if @honorario.hon_cantidad == nil
          @hon_cantidad = "blank"
        end
        if @honorario.hon_fecha == nil
          @hon_fecha = "blank"
        end
        @bandera = "blank"
        format.js { render "create.js"}
      else
        id = params[:construction_id]
        @honorario.construction_id = id
        if @honorario.save
          format.html {redirect_to index_honorary_path(:construction_id => id), :notice => "Registro de abono guardado con exito"}
        end
      end
    end
  end

#  def show
#    @honorario = Honorary.find(params[:id])
#  end

  def eliminar
    @honorario = Honorary.find(params[:id])
    respond_to do |format|
      format.js { render "eliminar.js"}
    end
  end

  def destroy
    @honorario = Honorary.find(params[:id])
    @honorario.destroy
    redirect_to index_honorary_path(:construction_id => @honorario.construction_id)
  end

  def edit
   @honorario = Honorary.find(params[:id])
   respond_to do |format|
     format.js { render "edit.js"}
   end
  end

  def update
    @honorario = Honorary.new(params[:honorary])
    @bandera = ""
    @hon_cantidad = ""
    @hon_fecha = ""

    respond_to do |format|
      if (@honorario.hon_cantidad == nil) or (@honorario.hon_fecha == nil)
        if @honorario.hon_cantidad == nil
          @hon_cantidad = "blank"
        end
        if @honorario.hon_fecha == nil
          @hon_fecha = "blank"
        end
        @bandera = "blank"
        format.js { render "update.js"}
      else
        @honorario = Honorary.find(params[:id])
        if @honorario.update_attributes(params[:honorary])
          format.html {redirect_to index_honorary_path(:construction_id => @honorario.construction_id), :notice => "Registro de abono guardado con exito"}
        end
      end
    end
  end
end
