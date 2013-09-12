SmartDiscovery.controllers :linked_in do
  # get :index, :map => "/foo/bar" do
  #   session[:foo] = "bar"
  #   render 'index'
  # end

  # get :sample, :map => "/sample/url", :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get "/example" do
  #   "Hello world!"
  # end

  get :connect_with_ln do
    ln_auth_base_url = "https://www.linkedin.com/uas/oauth2/authorization?response_type=code"
    client_id_params = "client_id=#{get_app_client_id}"
    state_random_string = get_state_random_string
    state_params = "state=#{state_random_string}"
    redirect_uri_params = get_authorization_redirect_param
    redirect "#{ln_auth_base_url}&#{client_id_params}&#{state_params}&#{redirect_uri_params}"
  end

  get :authorize do
    code = params[:code]
    unless code.nil?
      if code == "access_denied"
        redirect get_app_base_url
      else
        ln_access_base_url = "https://www.linkedin.com/uas/oauth2/accessToken?grant_type=authorization_code"
        code_param = "code=#{code}"
        redirect_uri_params = get_authorization_redirect_param
        client_id_params = "client_id=#{get_app_client_id}"
        client_secret_param = "client_secret=#{get_app_secret_key}"
        redirect "#{ln_access_base_url}&#{code_param}&#{redirect_uri_params}&#{client_id_params}&#{client_secret_param}"
      end
    end
  end

  post :authorize do
    #logger.info("Request received with body: #{request.body.read}")
    request_hash = JSON.parse(request.body.read)
    user_access_token = request_hash["access_token"]
    #store user

    redirect get_app_base_url
  end

  
end
