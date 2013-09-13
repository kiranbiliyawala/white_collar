# Helper methods defined here can be accessed in any controller or view in the application

SmartDiscovery.helpers do
  # def simple_helper_method
  #  ...
  # end
  def get_standard_deviation(count_list)
    mean = get_mean(count_list)
    sd_sum = 0
    count_count = 0
    count_list.each do |count|
      sd_sum += (count-mean)**2
      count_count += 1
    end
    return Math.sqrt(sd_sum.to_f/13)
  end

  def get_mean(count_list)
    sum = 0
    count_count = 0
    count_list.each do |count|
      sum += count
      count_count += 1
    end
    return sum.to_f/13
  end

  def get_sum(count_list)
    sum = 0
    count_list.each do |count|
      sum += count
    end
    return sum
  end

  def get_max_standard_deviation(count_list)
    min = 10000000
    max = 0
    count_list.each do |count|
      if count < min
        min = count
      end
      if count > max
        max = count
      end
    end
    return (max-min)/2
  end
end
