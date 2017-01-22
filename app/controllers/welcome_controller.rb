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
      @url = "https://s3.amazonaws.com/wundergroundimages/snow.jpg"
    elsif @weather_words == "Snow"
      @url = "https://s3.amazonaws.com/wundergroundimages/snow.jpg"
    elsif @weather_words == "Flurries"
      @url = "https://s3.amazonaws.com/wundergroundimages/snow.jpg"
    elsif @weather_words == "Chance of Snow"
      @url = "https://s3.amazonaws.com/wundergroundimages/snow.jpg"
    elsif @weather_words == "Rain" 
      @url = "https://s3.amazonaws.com/wundergroundimages/rain.jpg"
    elsif @weather_words == "Chance Freezing Rain"
      @url = "https://s3.amazonaws.com/wundergroundimages/rain.jpg"
    elsif @weather_words == "Chance of Rain"
      @url = "https://s3.amazonaws.com/wundergroundimages/rain.jpg"
    elsif @weather_words == "Freezing Rain"
      @url = "https://s3.amazonaws.com/wundergroundimages/rain.jpg"
    elsif @weather_words == "Chance of Thunderstorms"
      @url = "https://s3.amazonaws.com/wundergroundimages/thunder.jpg"
    elsif @weather_words == "Thunderstorms"
      @url = "https://s3.amazonaws.com/wundergroundimages/thunder.jpg"
    elsif @weather_words == "Partly Sunny"
      @url = "https://s3.amazonaws.com/wundergroundimages/sun.jpg"
    elsif @weather_words == "Clear"
      @url = "https://s3.amazonaws.com/wundergroundimages/sun.jpg"
    elsif @weather_words == "Sunny"
      @url = "https://s3.amazonaws.com/wundergroundimages/sun.jpg"
    elsif @weather_words == "Mostly Sunny" 
      @url = "https://s3.amazonaws.com/wundergroundimages/sun.jpg"
    elsif @weather_words == "Cloudy"
      @url = "https://s3.amazonaws.com/wundergroundimages/cloudy.jpg"
    elsif @weather_words == "Overcast"
      @url = "https://s3.amazonaws.com/wundergroundimages/cloudy.jpg"
    elsif @weather_words == "Mostly Cloudy"
      @url = "https://s3.amazonaws.com/wundergroundimages/cloudy.jpg"
    elsif @weather_words == "Partly Cloudy"
      @url = "https://s3.amazonaws.com/wundergroundimages/cloudy.jpg"
	  elsif @weather_words == "Fog"
      @url = "https://s3.amazonaws.com/wundergroundimages/haze.jpg"
    elsif @weather_words == "Haze"
      @url = "https://s3.amazonaws.com/wundergroundimages/haze.jpg"
    else
    	@url = "https://s3.amazonaws.com/wundergroundimages/map.jpg"
    end
  
		   
    end
    	
  
end
 
