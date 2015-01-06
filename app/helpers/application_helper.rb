module ApplicationHelper

  def formated_date(date)
    date.strftime('%m-%d-%Y')
  end

  def full_path(absolute_url)
    request.protocol + request.host_with_port + absolute_url
  end

end
