require 'digest/md5'

class UsersController < ApplicationController
  def login_form
    @md5 = params[:md5]
    map = Md5Map.find_by(md5: @md5)
    if map == nil
      flash.now[:error] = "Invalid MD5"
      render 'error' and return
    end
    appid = map.appid
    app = ThuApp.find_by(appid: appid)
    if app == nil
      flash.now[:error] = "Invalid MD5"
      render 'error' and return
    end
    @app_name = app.name
    @redirect_path = params[:redirect_path]
    @seq = params[:seq]
  end

  def login
    app = params[:app]
    user = User.validate(params[:user][:username], params[:user][:password])
    if user == nil
      flash[:notice] = 'Invalid username or password!'
      redirect_to "/login/form/#{app[:md5]}/#{app[:seq]}/#{app[:redirect_path]}"
      return
    else
      appid = Md5Map.find_by(md5: app[:md5]).appid
      app = ThuApp.find_by(appid: appid)
      ticket = create_ticket(app, user)
      redirect_to "#{app.prefix}/#{params[:app][:redirect_path]}?ticket=#{ticket.ticket}"
      return
    end
  end

  def check_ticket
    app = ThuApp.find_by(appid: params[:appid])
    ticket = Ticket.find_by(ticket: params[:ticket])
    if app != nil && ticket != nil && ticket.app_id == app.id && ticket.ip == params[:user_ip]
      user = User.find ticket.user_id
      ticket.destroy
      render text: "code=0:#{user.render_text}"
      return
    else
      render text: "code=1"
      return
    end
  end

  private

  def create_ticket(app, user)
    h = {}
    h[:ticket] = Digest::MD5.hexdigest(app.appid + user.real_name + Time.now.to_s)
    h[:app_id] = app.id
    h[:user_id] = user.id
    h[:ip] = request.remote_ip.gsub(/[.]/, '_')
    return Ticket.create(h)
  end

  def permit_params(form_params)
    form_params.permit(
      :ticket, :app_id, :user_id, :ip
    )
  end
end
