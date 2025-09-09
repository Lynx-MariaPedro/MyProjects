// Function to mediate weather condition codes and return simplified weather states
public function getWeatherState(int conditionCode) returns string {
    match conditionCode {
        1000 => {
            return "Clear";
        }
        1003|1006 => {
            return "Cloudy";
        }
        1009 => {
            return "Overcast";
        }
        1030|1135|1147 => {
            return "Foggy";
        }
        1063|1150|1153|1180|1183|1186|1189|1240 => {
            return "Light Rain";
        }
        1192|1195|1243|1246 => {
            return "Heavy Rain";
        }
        1066|1210|1213|1216|1219|1255|1258 => {
            return "Snowy";
        }
        1222|1225 => {
            return "Heavy Snow";
        }
        1069|1072|1168|1171|1198|1201|1204|1207|1249|1252 => {
            return "Freezing Conditions";
        }
        1087|1273|1276|1279|1282 => {
            return "Stormy";
        }
        1114|1117 => {
            return "Severe Snow";
        }
        1237|1261|1264 => {
            return "Ice Pellets";
        }
        _ => {
            return "Unknown";
        }
    }
}

// Function to get detailed weather state information
public function getDetailedWeatherInfo(int conditionCode, int isDay) returns WeatherStateInfo {
    string basicState = getWeatherState(conditionCode);
    string timeOfDay = isDay == 1 ? "Day" : "Night";
    
    return {
        basicState: basicState,
        conditionCode: conditionCode,
        timeOfDay: timeOfDay,
        severity: getSeverityLevel(conditionCode)
    };
}

// Helper function to determine severity level
function getSeverityLevel(int conditionCode) returns string {
    match conditionCode {
        1000|1003 => {
            return "Low";
        }
        1006|1009|1030|1063|1066|1069|1150|1153|1180|1183|1210|1213 => {
            return "Moderate";
        }
        1087|1192|1195|1222|1225|1243|1246|1273|1276|1279|1282 => {
            return "High";
        }
        1114|1117 => {
            return "Severe";
        }
        _ => {
            return "Moderate";
        }
    }
}