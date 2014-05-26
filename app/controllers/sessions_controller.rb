class SessionsController < ApplicationController
  def new
  end

  def create
#    user = User.authenticate(params[:username], params[:password])
    user = login(params[:username], params[:password])
    rol = Role.find_by_rol_nombre("Administrador")
    if user #PARA SABER SI EL USUARIO Y CONTRASEÑA SON CORRECTOS
      #SI USUARIO Y CONTRASEÑA SON CORRECTOS, VERIFICAMOS SI LA CUENTA HA SIDO ACTIVADA
      persona = Persona.joins(:users).where(:personas_roles_users=>{:user_id=>user.id, :role_id=>["1","2"]}).first
      if persona and persona.pers_estado == "A"
        if User.joins(:roles).where(:id => user.id, :roles => {:id => rol.id}).exists? == false
          Amount.estados(user.id)
        end
        user = User.find(user.id)
        if user.usu_estado == "A"
          session[:user_id] = user.id
          redirect_to index_construction_path, :notice => "Conectado!"
        else
          redirect_to deudas_path, :notice => "Error!"
        end
      else
        redirect_to cuenta_inactiva_path
      end
    else
      redirect_to falla_sesion_path, :notice => "Error!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Desconectado!"
  end
end