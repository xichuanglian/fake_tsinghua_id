require 'digest/md5'

class ThuAppsController < ApplicationController
  def list
    @apps = ThuApp.all
  end

  def update
    if params[:app][:appid] == nil || params[:app][:appid].size < 5
      flash[:notice] = 'App ID too short'
      redirect_to '/app/new' and return
    end
    if params[:app][:prefix] == nil || params[:app][:prefix].size < 10
      flash[:notice] = 'Prefix too short'
      redirect_to '/app/new' and return
    end
    if Digest::MD5.hexdigest(params[:secret]) == '982f3365f590a985971fd94981f62710'
      app = ThuApp.create!(permit_params(params[:app]))
      md5h = {md5: Digest::MD5.hexdigest(app.appid), appid: app.appid}
      md5m = Md5Map.create!(md5h)
      if app == nil
        flash[:notice] = 'Failed to add app'
      else
        flash[:notice] = "Successfully added app, md5:#{md5m.md5}"
      end
    else
      flash[:notice] = 'Invalid secret!'
    end
    redirect_to '/app/list'
  end

  def new
  end

  private
  def permit_params(form_params)
    form_params.permit(
      :appid, :name, :prefix, :seq, :prefix, :default_path
    )
  end
  def permit_md5_params(h)
    h.permit(:md5, :appid)
  end
end
