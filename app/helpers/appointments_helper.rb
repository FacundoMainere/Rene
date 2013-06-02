# Helper methods defined here can be accessed in any controller or view in the application
require 'active_support/all'

Rene::App.helpers do
  # def simple_helper_method
  # ...
  # end

  def render_date(date)
    date.to_datetime
  end

  def render_hour(hour)
    hour[0..1].to_i
  end
   
  def render_minutes(hour)
    hour[3..4].to_i
  end

end
