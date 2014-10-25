class ErrorsController < ApplicationController
  # match '/404', to: 'errors#file_not_found', via: :all
  def file_not_found
    @status = 404
    render_error(@status, nil)
  end

  # match '/422', to: 'errors#unprocessable', via: :all
  def unprocessable
    @status = 422
    render_error(@status, nil)
  end

  # match '/500', to: 'errors#internal_server_error', via: :all
  #def internal_server_error
  #end
  
  private
    def render_error(status, exception)
      @url = request.url
      @status = status
      sendmail(@status, exception, @url)
      respond_to do |format|
        format.html { render template: "errors/file_not_found", status: status }
        format.json { render json: @status }
        format.all { render nothing: true, status: status }
      end
    end
    
    def sendmail(status, exception, url)
      @status = status
      if spree_current_user
        user = spree_current_user.email
      else
        user = t('emailer_error.guest')
      end
      Emailer.createmail(user, @status, exception, url).deliver
    end
    
end
