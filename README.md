# Sweater Weather

This repo serves as a solo, [final project](https://backend.turing.io/module3/projects/sweater_weather/) for Module 3 of [Turing School of Software & Design's Back-End program](https://backend.turing.io/). The submission of this project entailed a techincal presentation including a live demo and discussion regarding of code organization as well as happy and sad path test coverage.  

Sweater Weather is the back-end of a hypothetical application for planning road trips. The app allows users to see the current weather as well as the forecasted weather at their destination. This repo exposes the API that satisfies the (hypothetical) front-end team’s requirements.

## Learning Goals
* Expose an API that aggregates data from multiple external APIs: _`forecast` endpoint aggregates data from two third party APIs_
* Expose an API that requires an authentication token: _`roadtrip` endpoint requires API key included in request body_
* Expose an API for CRUD functionality: _`users` endpoint creates User records_
* Determine completion criteria based on the needs of other developers: _each issue in my [project board](https://github.com/rrabinovitch/sweater_weather/projects/1?fullscreen=true) outlines implementation details and includes screenshots of relevant info provided by the "front end"_
* Research, select, and consume an API based on your needs as a developer: _[Pexels API](https://www.pexels.com/api/?locale=en-US) selected for `backgrounds` endpoint_

## Local Setup
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

## Endpoints
* responses are all JSON API 1.0 Compliant
* GET requests require params submitted via query params
* POST requests require params submitted via the request body
* make sure to follow the local set up instructions above and run `rails s` before consuming these endpoints

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
* body must include `email`, `password`, and `password_confirmation`
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
* body must include `email` and `password`
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
< to be filled in >

**** add postman button
**** list technologies and lang+framework versions
**** list all third party endpoints used
