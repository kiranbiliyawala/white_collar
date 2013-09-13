require 'net/http'
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
    scope_params = "scope=r_fullprofile"
    state_params = "state=#{state_random_string}"
    redirect_uri_params = get_authorization_redirect_param
    redirect "#{ln_auth_base_url}&#{client_id_params}&#{state_params}&#{redirect_uri_params}&#{scope_params}"
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
        uri = URI.parse("#{ln_access_base_url}&#{code_param}&#{redirect_uri_params}&#{client_id_params}&#{client_secret_param}")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = Net::HTTP::Get.new(uri.request_uri)

        access_response = http.request(request)
        #p access_response.body.to_json
        p access_response
        user_access_token = JSON.parse(access_response.body)["access_token"]
        p user_access_token
        ###store user
        uri = URI.parse("https://api.linkedin.com/v1/people/~:(first-name,last-name,positions)?oauth2_access_token=#{user_access_token}")
        p uri
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Get.new(uri.request_uri)

        response = http.request(request)
        personal_profile = Hash.from_xml(response.body)
        positions = personal_profile["person"]["positions"]["position"]
        p positions
        positions.each do |position|
          if position["is_current"] == "true"
            title = position["title"]
            company_name = position["company"]["name"]
            p title, company_name
          end
        end
      end
    end
  end

  post :authorize do
    #logger.info("Request received with body: #{request.body.read}")
    request_hash = JSON.parse(request.body.read)

    redirect get_app_base_url
  end

  
end
