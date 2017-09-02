module Eventable
  require 'time_difference'
  extend ActiveSupport::Concern
  included do
    before_action :set_time, only: [:create]
    before_action :clean_date_time, only: [:create]
    #before_action :set_user, only: [:create]
  end

  def set_time
    start_days = params["event"]["start_time(3i)"].to_i
    end_days = params["event"]["end_time(3i)"].to_i
    @day_diff = end_days - start_days 
  end
    
  def format_date(hash,field)
    #date_and_time = '%Y-%m-%d %H:%M:%S'
    time_str = hash["event"]["#{field}(1i)"].to_s + "-" +
      hash["event"]["#{field}(2i)"].to_s + "-" + 
      hash["event"]["#{field}(3i)"].to_s + " " +
      hash["event"]["#{field}(4i)"].to_s + ":" +
      hash["event"]["#{field}(5i)"].to_s + ":00"
      return time_str

  end
  
  def clean_date_time
    count = @day_diff 
    hash = params.to_unsafe_h.clone
    data = Array.new
    if count > 0
      (0..count).each do |i| 
        data << fill_hash(hash,i)
      end
    else
      data << fill_hash(hash)
    end
    return data
  end
  
  def set_user
    @user = User.find_by(name: params["event"]["name"])
  end
  def insertable_hash(h, day, hour=0)
    hash = h.clone
    hash["event"]["user_id"] = @user.id
    hash["event"]["start_time(3i)"] = day
    hash["event"]["end_time(3i)"] = day
    stime = format_date(hash,"start_time")
    etime = format_date(hash,"end_time")
    hash["event"]["start_time"] = stime
    hash["event"]["end_time"] = etime 
    return hash
   
  end
  def fill_hash(hash, count=0)
    ntime = count + params["event"]["start_time(3i)"].to_i
    h = insertable_hash(hash,ntime)
    h2 = clean_params(h).clone
    return h2
  end
    
  def clean_params(h)
    h2 = h[:event].except("start_time(1i)", "start_time(2i)",
                             "start_time(3i)",
                             "start_time(4i)",
                             "start_time(5i)",
                             "end_time(1i)",
                             "end_time(2i)",
                             "end_time(3i)",
                             "end_time(4i)",
                             "end_time(5i)").clone
    return h2
  end
end
