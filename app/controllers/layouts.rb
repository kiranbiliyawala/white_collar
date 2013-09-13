SmartDiscovery.controllers :layouts do
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end

  get :index do
    render 'layouts/application'
  end

  get :white_collar do
    url="http://172.17.84.172:3000/users/get_recommendations?current_user_id=ACGSHZT9YCUP9BX7TZXAG0UV9TTBXWAS&occupation=Engineer"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    fsn_details = JSON.parse(http.request(request).body)
    @fsns = []
    @image_url = {}
    fsn_details.each_key do |fsn|
      logger.info "fsn: #{fsn}, count: #{fsn_details[fsn]}"
      @fsns.push(fsn)
      cms_url="http://sp-cms-service18.nm.flipkart.com:26700/sp-cms-service/spService?api=productDWL&ids=#{fsn}"
      cms_uri = URI.parse(cms_url)
      cms_http = Net::HTTP.new(cms_uri.host, cms_uri.port)
      cms_request = Net::HTTP::Get.new(cms_uri.request_uri)
      cms_access_response = cms_http.request(cms_request).body
      logger.info "Access Response: #{cms_access_response}"
      unless cms_access_response[/http:\/\/img.*125x125.*?"/].nil?
        image_url=cms_access_response[/http:\/\/img.*125x125.*?"/][0..-2]
        image_url=image_url[image_url[/.*":"/].length..-1]
        logger.info "image url: #{image_url}"
        @image_url[fsn]=image_url
      else
        @image_url[fsn]="http://garywittmann.com/images/noimage.gif"
      end
    end

    @image_url.each_key do |image_url|
      logger.info "fsn: #{image_url}, url: #{@image_url[image_url]}"
    end

    #cms_url="http://sp-cms-service18.nm.flipkart.com:26700/sp-cms-service/spService?api=productDWL&ids="
    #cms_uri = URI.parse(cms_url)
    #cms_http = Net::HTTP.new(cms_uri.host, cms_uri.port)
    #cms_request = Net::HTTP::Get.new(cms_uri.request_uri)
    #cms_access_response = cms_http.request(cms_request).body
    #logger.info "Access Response: #{cms_access_response}"
    #@image_url=cms_access_response[/http:\/\/img.*125x125.*?"/][0..-2]
    #@image_url=@image_url[@image_url[/.*":"/].length..-1]
    #logger.info "image url: #{@image_url}"


    @days = [ 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday' ]
    render 'layouts/application'
  end

  get :test do
    logger.info "request body: #{params}"
    request_hash = JSON.parse(request.body.read)
    age=request_hash['hdn_age']
    occupation=request_hash['hdn_occupation']
    organisation=request_hash['hdn_organisation']
    gender=request_hash['hdn_department']
    location=request_hash['hdn_location']
    url="http://172.17.84.172:3000/users/get_recommendations?current_user_id=ACGSHZT9YCUP9BX7TZXAG0UV9TTBXWAS&occupation=#{occupation}&age=#{age}&organization=#{organisation}&gender=#{gender}&location=#{location}"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    fsn_details = JSON.parse(http.request(request).body)
    @fsns = []
    @image_url = {}
    fsn_details.each_key do |fsn|
      logger.info "fsn: #{fsn}, count: #{fsn_details[fsn]}"
      @fsns.push(fsn)
      cms_url="http://sp-cms-service18.nm.flipkart.com:26700/sp-cms-service/spService?api=productDWL&ids=#{fsn}"
      cms_uri = URI.parse(cms_url)
      cms_http = Net::HTTP.new(cms_uri.host, cms_uri.port)
      cms_request = Net::HTTP::Get.new(cms_uri.request_uri)
      cms_access_response = cms_http.request(cms_request).body
      logger.info "Access Response: #{cms_access_response}"
      unless cms_access_response[/http:\/\/img.*125x125.*?"/].nil?
        image_url=cms_access_response[/http:\/\/img.*125x125.*?"/][0..-2]
        image_url=image_url[image_url[/.*":"/].length..-1]
        logger.info "image url: #{image_url}"
        @image_url[fsn]=image_url
      else
        @image_url[fsn]="http://garywittmann.com/images/noimage.gif"
      end
    end

    @image_url.each_key do |image_url|
      logger.info "fsn: #{image_url}, url: #{@image_url[image_url]}"
    end
    render 'layouts/white_collar'
  end

end
