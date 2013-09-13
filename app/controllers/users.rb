SmartDiscovery.controllers :users do
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

  get "/" do
    "Awesome!!"
  end

  get "get_recommendations" do
    current_user_id = params["current_user_id"]
    filter_query = ""
    age = params["age"]
    age_flag = false
    gender_flag = false
    location_flag = false
    occupation_flag = false
    organization_flag = false
    if !age.nil? && age != "all"
      filter_query = "age >= #{age.to_i - 9} AND age <= #{age.to_i}"
      age_flag = true
    end
    gender = params["gender"]
    if !gender.nil? && gender != "all"
      gender_query = "gender = '#{gender}'"
      if filter_query.length > 0
        filter_query += " AND "
      end
      filter_query += gender_query
      gender_flag = true
    end
    location = params["location"]
    if !location.nil? && location != "all"
      location_query = "state = '#{location}'"
      if filter_query.length > 0
        filter_query += " AND "
      end
      filter_query += location_query
      location_flag = true
    end
    results1 = FkUserProfile.where(filter_query).select("fkuid")
    user_ids1 = []
    results1.each do |result|
      user_ids1 << result[:fkuid]
    end
    p user_ids1

    filter_query = ""
    occupation = params["occupation"]
    if !occupation.nil? && occupation != "all"
      occupation_query = "designation = '#{occupation}'"
      if filter_query.length > 0
        filter_query += " AND "
      end
      filter_query += occupation_query
      occupation_flag = true
    end
    organisation = params["organization"]
    if !organisation.nil? && organisation != "all"
      organisation_query = "company = '#{organisation}'"
      if filter_query.length > 0
        filter_query += " AND "
      end
      filter_query += organisation_query
      organisation = true
    end
    results2 = UserOccupationHistory.where(filter_query).select("fkuid")
    user_ids2 = []
    results2.each do |result|
      user_ids2 << result[:fkuid]
    end
    p user_ids2

    user_ids = user_ids1 & user_ids2
    p user_ids

    my_connections = params["my_connections"]
    if my_connections == "true"
      results3 = LnConnection.where(:fkuid_from => current_user_id).select("fkuid_to")
      user_ids3 = []
      results3.each do |result|
        user_ids3 << result[:fkuid_to]
      end
      user_ids = user_ids & user_ids3
      p user_ids
    end

    fsns =  OrderInfo.where("fkuid IN (?)", user_ids).select("DISTINCT fsn")
    p fsns
    fsn_score_map = {}
    fsns.each do |fsn|
      group_by_params = "#{",designation" if occupation_flag}#{",age" if age_flag}#{",gender" if gender_flag}#{",location" if location_flag}#{",company" if organization_flag}"
      the_query_string = "select OI.fsn,count(*)#{group_by_params} from fk_user_profiles FUP " +
                          "join order_infos OI on FUP.fkuid = OI.fkuid and OI.fsn = '#{fsn[:fsn]}' "+
                          "join user_occupation_histories UIH on FUP.fkuid = UIH.fkuid group by OI.fsn#{group_by_params}"
      p the_query_string
      results = ActiveRecord::Base.connection.execute(the_query_string)
      fsn_group_by_count_list = []
      fsn_group_count = 0
      results.each do |result|
        fsn_group_by_count_list << result[1]
        counter = 2
        if occupation_flag
          if occupation != result[counter]
            next
          end
          counter += 1
        end
        if age_flag
          if age != result[counter]
            next
          end
          counter += 1
        end
        if gender_flag
          if gender != result[counter]
            next
          end
          counter += 1
        end
        if location_flag
          if location != result[counter]
            next
          end
          counter += 1
        end
        if organization_flag
          if organisation != result[counter]
            next
          end
        end
        fsn_group_count = result[1]
      end
      p fsn,get_standard_deviation(fsn_group_by_count_list),get_mean(fsn_group_by_count_list),fsn_group_count,fsn_group_count<get_mean(fsn_group_by_count_list)
      if get_standard_deviation(fsn_group_by_count_list) < 1 || fsn_group_count.to_f <= get_mean(fsn_group_by_count_list)
        next
      else
        fsn_score = ((60*(fsn_group_count/get_sum(fsn_group_by_count_list)))+(40*(get_standard_deviation(fsn_group_by_count_list)/get_max_standard_deviation(fsn_group_by_count_list))))
        fsn_score_map[fsn[:fsn]] = fsn_score.round(2)
      end
    end
    p fsn_score_map
    fsn_score_map = Hash[fsn_score_map.sort_by {|k,v| v}.reverse[0..15]]
    return fsn_score_map.to_json


  end

  
end
