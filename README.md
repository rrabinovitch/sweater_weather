# Sweater Weather

This repo serves as a solo, [final project](https://backend.turing.io/module3/projects/sweater_weather/) for Module 3 of [Turing School of Software & Design's Back-End program](https://backend.turing.io/).  

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
