class PiecesController < ApplicationController
  def index
    @partes = Piece.find(:all)
    @parte = Piece.new
    respond_to do |format|
      format.js
      format.html
    end
  end

  def new
    @parte = Piece.new
  end

  def create
    @parte = Piece.new(params[:piece])
    respond_to do |format|
      @parte.part_nombre = @parte.part_nombre.gsub(/\s+/, " ").strip
      if @parte.part_nombre == ""
        @bandera = "blank"
        format.js { render "create.js"}
      else
        if Piece.find_by_part_nombre(@parte.part_nombre)
          @bandera = "exist"
          format.js { render "create.js"}
        else
          if @parte.save
            format.html { redirect_to index_piece_path, :notice => "Registrado"}
          end
        end
      end
    end
  end

  def show
    @parte = Piece.find(params[:id])
  end

  def eliminar
    @parte = Piece.find(params[:id])
    respond_to do |format|
      if ConstructionsPiece.find_by_piece_id(@parte.id)
        format.js { render "no_eliminar.js"}
      else
        format.js { render "eliminar.js"}
      end
    end
  end

  def destroy
    @parte = Piece.find(params[:id])
    @parte.destroy
    redirect_to index_piece_path
  end

  def edit
   @parte = Piece.find(params[:id])
   respond_to do |format|
     format.js { render "edit.js"}
   end
  end

  def update
    @parte = Piece.new(params[:piece])
    respond_to do |format|
      @parte.part_nombre = @parte.part_nombre.gsub(/\s+/, " ").strip
      if @parte.part_nombre == ""
        @bandera = "blank"
        format.js { render "update.js"}
      else
        if Piece.find_by_part_nombre(@parte.part_nombre)
          @bandera = "exist"
          format.js { render "update.js"}
        else
          @parte = Piece.find(params[:id])
          if @parte.update_attributes(params[:piece])
            format.html { redirect_to index_piece_path, :notice => "Registro Actualizado con Exito"}
          end
        end
      end
    end
  end
end
