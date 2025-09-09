import ballerina/http;

listener http:Listener httpDefaultListener = http:getDefaultListener();

service /WeatherWorld on httpDefaultListener {
    
    // Original endpoint returning raw weather data
    resource function get world(string location) returns error|json|http:InternalServerError {
        do {
            WeatherData weatherResponse = check weatherAPIClient->get(string `/current.json?q=${location}&key=${WEATHER_API_KEY}`);
            return weatherResponse;
        } on fail error err {
            return error("unhandled error", err);
        }
    }
    
    // New endpoint with mediated weather states
    resource function get mediated(string location) returns MediatedWeatherResponse|error|http:InternalServerError {
        do {
            WeatherData weatherResponse = check weatherAPIClient->get(string `/current.json?q=${location}&key=${WEATHER_API_KEY}`);
            
            // Mediate the weather condition code
            int conditionCode = weatherResponse.current.condition.code;
            int isDay = weatherResponse.current.is_day;
            WeatherStateInfo weatherState = getDetailedWeatherInfo(conditionCode, isDay);
            
            MediatedWeatherResponse mediatedResponse = {
                location: weatherResponse.location,
                current: weatherResponse.current,
                weatherState: weatherState
            };
            
            return mediatedResponse;
        } on fail error err {
            return error("unhandled error", err);
        }
    }
    
    // Endpoint to get just the weather state
    resource function get state(string location) returns WeatherStateInfo|error|http:InternalServerError {
        do {
            WeatherData weatherResponse = check weatherAPIClient->get(string `/current.json?q=${location}&key=${WEATHER_API_KEY}`);
            
            int conditionCode = weatherResponse.current.condition.code;
            int isDay = weatherResponse.current.is_day;
            WeatherStateInfo weatherState = getDetailedWeatherInfo(conditionCode, isDay);
            
            return weatherState;
        } on fail error err {
            return error("unhandled error", err);
        }
    }
}