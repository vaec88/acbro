class ProvincesController < ApplicationController
  def index
    @provincias = Province.find(:all)
    @provincia = Province.new
    respond_to do |format|
      format.js
      format.html
    end
  end

  def new
    @provincia = Province.new
  end

  def create
    @provincia = Province.new(params[:province])
    respond_to do |format|
      @provincia.prov_nombre = @provincia.prov_nombre.gsub(/\s+/, " ").strip
      if @provincia.prov_nombre == ""
        @bandera = "blank"
        format.js { render "create.js"}
      else
        if Province.find_by_prov_nombre(@provincia.prov_nombre)
          @bandera = "exist"
          format.js { render "create.js"}
        else
          if @provincia.save
            format.html { redirect_to index_province_path, :notice => "Registrado"}
          end
        end
      end
    end
  end

  def show
    @provincia = Province.find(params[:id])
  end

  def eliminar
    @provincia = Province.find(params[:id])
    respond_to do |format|
      if Construction.joins(:parish=>:canton).where(:cantons=>{:province_id=>@provincia.id}).exists?
        format.js { render "no_eliminar.js"}
      else
        format.js { render "eliminar.js"}
      end
    end
  end
  
  def destroy
    @provincia = Province.find(params[:id])
    @provincia.destroy
    redirect_to index_province_path
  end

  def edit
   @provincia = Province.find(params[:id])
   respond_to do |format|
     format.js { render "edit.js"}
   end
  end

  def update
    @provincia = Province.new(params[:province])
    respond_to do |format|
      @provincia.prov_nombre = @provincia.prov_nombre.gsub(/\s+/, " ").strip
      if @provincia.prov_nombre == ""
        @bandera = "blank"
        format.js { render "update.js"}
      else
        if Province.find_by_prov_nombre(@provincia.prov_nombre)
          @bandera = "exist"
          format.js { render "update.js"}
        else
          @provincia = Province.find(params[:id])
          if @provincia.update_attributes(params[:province])
            format.html { redirect_to index_province_path, :notice => "Registrado"}
          end
        end
      end
    end
  end
end