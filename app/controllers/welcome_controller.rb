class WelcomeController < ApplicationController
  def test
  	 response = HTTParty.get("http://api.wunderground.com/api/#{ENV['wunderground_api_key']}/geolookup/conditions/q/AZ/Phoenix.json")
  	  @location = response['location']['city']
	  @temp_f = response['current_observation']['temp_f']
	  @temp_c = response['current_observation']['temp_c']
	  @weather_icon = response['current_observation']['icon_url']
	  @weather_words = response['current_observation']['weather'] 
	  @forecast_link = response['current_observation']['forecast_url']
	  @real_feel = response['current_observation']['feelslike_f']
  end

  def index

    @states = %w(HI AK CA OR WA ID UT NV AZ NM CO WY MT ND SD NB KS OK TX LA AR MO IA MN WI IL IN MI OH KY TN MS AL GA FL SC NC VA WV DE MD PA NY NJ CT RI MA VT NH ME DC).sort!

    results = HTTParty.get("http://api.wunderground.com/api/#{Figaro.env.wunderground_api_key}/geolookup/conditions/q/AZ/Phoenix.json")

    if params[:city] != nil
      params[:city].gsub!(" ", "_")
    end

    if params[:state] != "" && params[:city] != ""
      if params[:state] != nil && params[:city] != nil
        results = HTTParty.get("http://api.wunderground.com/api/#{Figaro.env.wunderground_api_key}/geolookup/conditions/q/#{params[:state]}/#{params[:city]}.json")
      end
    else
      results = HTTParty.get("http://api.wunderground.com/api/#{Figaro.env.wunderground_api_key}/geolookup/conditions/q/AZ/Phoenix.json")
    end 
    # if no error is returned from the call, we fill our instants variables with the result of the call
		 
    @location = results['location']['city']
    @temp_f = results['current_observation']['temp_f']
    @temp_c = results['current_observation']['temp_c']
    @weather_icon = results['current_observation']['icon_url']
    @weather_words = results['current_observation']['weather']
    @forecast_link = results['current_observation']['forecast_url']
    @real_feel_f = results['current_observation']['feelslike_f']
    @real_feel_c = results['current_observation']['feelslike_c']

    if @weather_words == "Chance of Flurries" 
      @url = "/assets/snow.jpg"
    elsif @weather_words == "Snow"
      @url = "/assets/snow.jpg"
    elsif @weather_words == "Flurries"
      @url = "/assets/snow.jpg"
    elsif @weather_words == "Chance of Snow"
      @url = "/assets/snow.jpg"
    elsif @weather_words == "Rain" 
      @url = "/assets/rain.jpg"
    elsif @weather_words == "Chance Freezing Rain"
      @url = "/assets/rain.jpg"
    elsif @weather_words == "Chance of Rain"
      @url = "/assets/rain.jpg"
    elsif @weather_words == "Freezing Rain"
      @url = "/assets/rain.jpg"
    elsif @weather_words == "Chance of Thunderstorms"
      @url = "/assets/thunder.jpg"
    elsif @weather_words == "Thunderstorms"
      @url = "/assets/thunder.jpg"
    elsif @weather_words == "Partly Sunny"
      @url = "/assets/sun.jpg"
    elsif @weather_words == "Clear"
      @url = "/assets/sun.jpg"
    elsif @weather_words == "Sunny"
      @url = "/assets/sun.jpg"
    elsif @weather_words == "Mostly Sunny" 
      @url = "/assets/sun.jpg"
    elsif @weather_words == "Cloudy"
      @url = "/assets/cloudy.jpg" 
    elsif @weather_words == "Overcast"
      @url = "/assets/cloudy.jpg"
    elsif @weather_words == "Mostly Cloudy"
      @url = "/assets/cloudy.jpg"
    elsif @weather_words == "Partly Cloudy"
      @url = "/assets/cloudy.jpg"
	  elsif @weather_words == "Fog"
      @url = "/assets/haze.jpg"
    elsif @weather_words == "Haze"
      @url = "/assets/haze.jpg"
    else
    	@url = "/assets/map.jpg"
    end
  
		   
    end
    	
  
end
 
