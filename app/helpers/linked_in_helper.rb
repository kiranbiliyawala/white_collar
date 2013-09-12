# Helper methods defined here can be accessed in any controller or view in the application

SmartDiscovery.helpers do
  # def simple_helper_method
  #  ...
  # end
  def get_app_client_id
    return "kag9gzdhergf"
  end

  def get_app_secret_key
    return "bu1UrZWX0PZTXwiN"
  end

  def get_state_random_string
    return "MyRandomString"
  end

  def get_app_base_url
    return "http://172.17.84.172:3000"
  end

  def get_authorization_redirect_param
    return "redirect_uri=#{get_app_base_url}/linked_in/authorize"
  end
end
