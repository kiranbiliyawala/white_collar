# Helper methods defined here can be accessed in any controller or view in the application

SmartDiscovery.helpers do
  # def simple_helper_method
  #  ...
  # end
  def get_standard_deviation(count_list)
    sum = 0
    count_count = 0
    count_list.each do |count|
      sum += count
      count_count += 1
    end
    mean = sum/ count_count
    sd_sum = 0
    count_list.each do |count|
      sd_sum += (count-mean)**2
    end
    return Math.sqrt(sd_sum/count_count)
  end
end
