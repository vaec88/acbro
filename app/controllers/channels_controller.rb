class ChannelsController < ApplicationController
  def index
    @captaciones = Channel.find(:all)
    @captacion = Channel.new
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def new
    @captacion = Channel.new
  end

  def create
    @captacion = Channel.new(params[:channel])
    respond_to do |format|
      @captacion.capt_nombre = @captacion.capt_nombre.gsub(/\s+/, " ").strip
      if @captacion.capt_nombre == ""
        @bandera = "blank"
        format.js { render "create.js"}
      else
        if Channel.find_by_capt_nombre(@captacion.capt_nombre)
          @bandera = "exist"
          format.js { render "create.js"}
        else
          if @captacion.save
            format.html { redirect_to index_channel_path, :notice => "Registrado"}
          end
        end
      end
    end
  end

  def show
    @captacion = Channel.find(params[:id])
  end

  def eliminar
    @captacion = Channel.find(params[:id])
    respond_to do |format|
      if ConstructionsChannel.find_by_channel_id(@captacion.id)
        format.js { render "no_eliminar.js"}
      else
        format.js { render "eliminar.js"}
      end
    end
  end
  
  def destroy
    @captacion = Channel.find(params[:id])
    @captacion.destroy
    redirect_to index_channel_path
  end

  def edit
   @captacion = Channel.find(params[:id])
   respond_to do |format|
     format.js { render "edit.js"}
   end
  end

  def update
    @captacion = Channel.new(params[:channel])
    respond_to do |format|
      @captacion.capt_nombre = @captacion.capt_nombre.gsub(/\s+/, " ").strip
      if @captacion.capt_nombre == ""
        @bandera = "blank"
        format.js { render "update.js"}
      else
        if Channel.find_by_capt_nombre(@captacion.capt_nombre)
          @bandera = "exist"
          format.js { render "update.js"}
        else
          @captacion = Channel.find(params[:id])
          if @captacion.update_attributes(params[:channel])
            format.html { redirect_to index_channel_path, :notice => "Registrado"}
          end
        end
      end
    end
  end
end
