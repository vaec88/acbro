class ImagesController < ApplicationController
  def index
    @inmueble = Construction.find(params[:construction_id])
    @image = Image.new
  end

  def create
    @image = Image.new(params[:image])
    @image.construction_id = params[:construction_id]
    @image.save
    redirect_to index_images_path(:construction_id => params[:construction_id])
  end

  def eliminar
    @imagen = Image.find(params[:id])
    respond_to do |format|
      format.js { render "eliminar.js"}
    end
  end
  def destroy
    @imagen = Image.find(params[:id])
    construction = Construction.find(@imagen.construction_id)
    @imagen.destroy
    redirect_to index_images_path(:construction_id => construction)
  end
end
