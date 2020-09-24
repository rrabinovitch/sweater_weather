# Sweater Weather
**Built by Ruthie Rabinovitch**: [LinkedIn](https://www.linkedin.com/in/ruthie-r/), [Turing alumni portfolio](https://alumni.turing.io/alumni/ruthie-rabinovitch)

This repo serves as a solo, [final project](https://backend.turing.io/module3/projects/sweater_weather/) for Module 3 of [Turing School of Software & Design's Back-End program](https://backend.turing.io/). The submission of this project entailed a techincal presentation including a live demo and discussion regarding of code organization as well as happy and sad path test coverage.  

Sweater Weather is the back-end of a hypothetical application for planning road trips. The app allows users to see the current weather as well as the forecasted weather at their destination. This repo exposes the API that satisfies the (hypothetical) front-end team’s requirements.

To follow OOP principles, this project uses a facade design pattern and also implements POROs - yielding skinnier controllers and DRYer code, better following SPR, and only sending objects to serializers.

## Learning Goals
* Expose an API that aggregates data from multiple external APIs:
   * _`road trip` endpoint aggregates data from three third party end points ([MapQuest geocoding API](https://developer.mapquest.com/documentation/geocoding-api/), [MapQuest directions API](https://developer.mapquest.com/documentation/directions-api/), and [OpenWeather OneCall API](https://openweathermap.org/api/one-call-api)_
   * _`forecast` endpoint aggregates data from two third party endpoints ([MapQuest geocoding API](https://developer.mapquest.com/documentation/geocoding-api/) and [OpenWeather OneCall API](https://openweathermap.org/api/one-call-api))_
* Expose an API that requires an authentication token: _`roadtrip` endpoint requires API key included in request body_
* Expose an API for CRUD functionality: _`users` endpoint creates User records_
* Determine completion criteria based on the needs of other developers: _each issue in my [project board](https://github.com/rrabinovitch/sweater_weather/projects/1?fullscreen=true) outlines implementation details and includes screenshots of relevant info provided by the "front end"_
* Research, select, and consume an API based on your needs as a developer: _[Pexels API](https://www.pexels.com/api/?locale=en-US) selected for `backgrounds` endpoint_

## Future Iterations
* Implement sad path conditions and testing for `forecast` and `road trip` endpoints when location, origin, or destination information cannot be found and when entered using unrecognizable format
* DRY up `RoadTripsController` and `SessionsController` error message conditionals
* [Background image extension](https://github.com/rrabinovitch/sweater_weather/projects/1#card-46078542)

## Local Setup
**Version Requirements**
* ruby 2.5.3
* rails 5.2

1. `git clone git@github.com:rrabinovitch/sweater_weather.git`
2. `cd sweater_weather`
3. `bundle install`
4. `rails db:{create,migrate}
5. `figaro install` (this will generate a gitignored `config/application.yml` file)
6. obtain API keys from the following services:
    * [MapQuest](https://developer.mapquest.com/plan_purchase/steps/business_edition/business_edition_free/register)
    * [OpenWeather](https://openweathermap.org/appid)
    * [Pexels](https://www.pexels.com/api/?locale=en-US) (click 'Get Started')
6. add the API keys you obtained to `application.yml`:
    ```
    MAPQUEST_API_KEY: <your mapquest key>
    OPEN_WEATHER_API_KEY: <your openweather key>
    PEXELS_API_KEY: <your pexels key>
    ```
7. run `rails s` and explore the endpoints below!
8. run the test suite: `bundle exec rspec`

## Endpoints
[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/bd8f9f6f0083a657b732)
* responses are JSON API 1.0 Compliant
* GET requests require params submitted via query params
* POST requests require params submitted via the request body
* make sure to follow the local set up instructions above and run `rails s` before consuming these endpoints
* measurement units
  * temperature: Fahrenheit
  * time: Unix UTC format
  * humidity: percentage
  * visitbility: meters
  * precipitation: millimeters (combined value of rain and snow)  

### Forecast: retrieves weather for a city
Returns location info and current weather, as well as forecast info for the upcoming 8 hours and upcoming 5 days.

Request: `GET localhost:3000/api/v1/forecast?location=<city,state>`  

#### Example:
Request: `GET localhost:3000/api/v1/forecast?location=denver,co`  
Response body:
```
{
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "location": {
                "coordinates": {
                    "lat": 39.738453,
                    "lng": -104.984853
                },
                "city": "Denver",
                "state": "CO",
                "country": "US"
            },
            "current": {
                "datetime": 1600906634,
                "temp": 78.85,
                "description": "few clouds",
                "feels_like": 73.78,
                "humidity": 26,
                "visibility": 10000,
                "uv_index": 7.24,
                "sunrise": 1600865338,
                "sunset": 1600908912
            },
            "hourly": [
                {
                    "datetime": 1600905600,
                    "temp": 78.85
                },
                {
                    "datetime": 1600909200,
                    "temp": 79.47
                },
              < six more hourly forecasts >
            ],
            "daily": [
                {
                    "datetime": 1600884000,
                    "description": "scattered clouds",
                    "precipitation": 0.0,
                    "high_temp": 83.48,
                    "low_temp": 67.48
                },
                {
                    "datetime": 1600970400,
                    "description": "scattered clouds",
                    "precipitation": 0.0,
                    "high_temp": 87.66,
                    "low_temp": 67.24
                },
             < three more daily forecasts >
            ]
        }
    }
}
```

### Backgrounds: retrieves background image for a city's forecast show page
Returns location parameter, image url, and image credit info.

Request: `GET localhost:3000/api/v1/backgrounds?location=<city,state>`  

#### Example:
Request: `GET localhost:3000/api/v1/backgrounds?location=denver,co`  
Response body:
```
{
    "data": {
        "id": null,
        "type": "image",
        "attributes": {
            "location": "denver,co",
            "image_url": "https://www.pexels.com/photo/photo-of-people-holding-each-other-s-hands-3184423/",
            "credit": {
                "source": "pexels.com",
                "photographer": "fauxels"
            }
        }
    }
}
```

### User registration
Returns new user's id, email, and api key.

Request: `POST localhost:3000/api/v1/users` 
* body must include `email`, `password`, and `password_confirmation` params
* you will receive a 400 bad request error if an email is already in use, if there are any missing fields, and/or if the password fields do not match

#### Example:
Request: `POST localhost:3000/api/v1/users`  
Request body:
```
{"email": "whatever123@example.com",
  "password": "password",
   "password_confirmation": "password"}
```
Response body:
```
{
    "data": {
        "id": "1",
        "type": "user",
        "attributes": {
            "email": "whatever@example.com",
            "api_key": "8a32cb12-61bf-4746-8cab-118dcf6373c0"
        }
    }
}
```

### User login: logs in with a user's credentials
Returns authorized user's id, email, and api key.

Request: `POST localhost:3000/api/v1/sessions` 
* body must include `email` and `password` params
* you will receive a 401 unauthorized error if bad credentials are submitted

#### Example:
Request: `POST localhost:3000/api/v1/sessions`  
Request body:
```
{"email": "whatever@example.com",
  "password": "password"}
```
Response body:
```
{
    "data": {
        "id": "1",
        "type": "user",
        "attributes": {
            "email": "whatever@example.com",
            "api_key": "9167e13a-9fb2-49c9-8165-c64c2ff335b1"
        }
    }
}
```

### POST road_trip: allows user to plan a road trip
Returns road trip info: origin, destination, travel time, forecast temperature, forecast description, and user that road trip was created by

Request: `POST localhost:3000/api/v1/road_trip` 
* body must include `origin`, `destination`, and `api_key` params
* you will receive a 401 unauthorized error if bad credentials are submitted

#### Example:
Request: `POST localhost:3000/api/v1/road_trip`  
Request body:
```
{"origin": "Denver, CO",
   "destination": "Pueblo, CO",
   "api_key": "9167e13a-9fb2-49c9-8165-c64c2ff335b1"}
```
Response body:
```
{
    "data": {
        "id": "1",
        "type": "road_trip",
        "attributes": {
            "origin": "Denver, CO",
            "destination": "Pueblo, CO",
            "travel_time": 17,
            "forecast_temp": 86,
            "forecast_description": "clear sky",
            "user_id": 1
        }
    }
}
```
## Tools
**Version Requirements**
* ruby 2.5.3
* rails 5.2

**Gems**
* Faraday
* Figaro
* BCrypt
* FastJSON

**Testing**
* SimpleCov - yielding 100% coverage
* RSpec
* WebMock
* VCR
* ShouldaMatchers
* FactoryBot

**Third Party APIs and Endpoints**
* MapQuest
   * [Directions API - GET route](https://developer.mapquest.com/documentation/directions-api/route/get/)
   * [GeoCoding API - GET geocode address](https://developer.mapquest.com/documentation/geocoding-api/address/get/)
* OpenWeather
   * [OneCall API - GET forecast by coordinates](https://openweathermap.org/api/one-call-api)
* Pexels
   * [Image search API - GET image](https://www.pexels.com/api/documentation/#photos-search)
