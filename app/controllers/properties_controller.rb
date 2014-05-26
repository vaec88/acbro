class PropertiesController < ApplicationController
  def index
    @propiedades = Property.find(:all)
    @propiedad = Property.new
    respond_to do |format|
      format.js
      format.html
    end 
  end

  def new
    @propiedad = Property.new
  end

  def create
    @propiedad = Property.new(params[:property])
    respond_to do |format|
      @propiedad.propd_nombre = @propiedad.propd_nombre.gsub(/\s+/, " ").strip
      if @propiedad.propd_nombre == ""
        @bandera = "blank"
        format.js { render "create.js"}
      else
        if Property.find_by_propd_nombre(@propiedad.propd_nombre)
          @bandera = "exist"
          format.js { render "create.js"}
        else
          if @propiedad.save
            format.html { redirect_to index_property_path, :notice => "Registrado"}
          end
        end
      end
    end
  end

  def show
    @propiedad = Property.find(params[:id])
  end

  def eliminar
    @propiedad = Property.find(params[:id])
    respond_to do |format|
      if Construction.find_by_property_id(@propiedad.id)
        format.js { render "no_eliminar.js"}
      else
        format.js { render "eliminar.js"}
      end
    end
  end

  def destroy
    @propiedad = Property.find(params[:id])
    @propiedad.destroy
    redirect_to index_property_path
  end

  def edit
    @propiedad = Property.find(params[:id])
     respond_to do |format|
       format.js { render "edit.js"}
     end
  end

  def update
    @propiedad = Property.new(params[:property])
    respond_to do |format|
      @propiedad.propd_nombre = @propiedad.propd_nombre.gsub(/\s+/, " ").strip
      if @propiedad.propd_nombre == ""
        @bandera = "blank"
        format.js { render "update.js"}
      else
        if Property.find_by_propd_nombre(@propiedad.propd_nombre)
          @bandera = "exist"
          format.js { render "update.js"}
        else
          @propiedad = Property.find(params[:id])
          if @propiedad.update_attributes(params[:property])
            format.html { redirect_to index_property_path, :notice => "Registro Actualizado con Exito"}
          end
        end
      end
    end
  end
end
