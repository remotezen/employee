module ApplicationHelper

  def full_title(page_title = '')
    base_title = "Web Portal"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def shift_length(stime, etime)
    TimeDifference.between(stime,etime).in_hours
  end

  def flash_class(level)
      case level
          when :notice then "alert alert-info"
          when :success then "alert alert-success"
          when :error then "alert alert-error"
          when :alert then "alert alert-error"
      end
  end

  def timeable(t)
    str = t.to_s(:custom_datetime) + " "  + distance_of_time_in_words(Time.now, t) + " ago"
    content_tag(:code,str)
  end


  def time_distance(stime, etime, time="hours")
    if(time == "hours")
      str = TimeDifference.between(stime,etime).in_hours.to_i
    elsif(time == "days")
      str = TimeDifference.between(stime,etime).in_days.to_i
    end
    content_tag(:span, str, class: "success")
  end

  def plain_time(t)
    content_tag(:span, t.to_s(:custom_datetime))
  end


end

