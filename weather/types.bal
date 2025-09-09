type Location record {|
    string name;
    string region;
    string country;
    decimal lat;
    decimal lon;
    string tz_id;
    int localtime_epoch;
    string localtime;
|};

type Condition record {|
    string text;
    int code;
    string icon;
|};

type Current record {|
    int last_updated_epoch;
    string last_updated;
    decimal temp_c;
    decimal temp_f;
    int is_day;
    Condition condition;
    int wind_mph;
    decimal wind_kph;
    int wind_degree;
    string wind_dir;
    int pressure_mb;
    decimal pressure_in;
    decimal precip_mm;
    int precip_in;
    int humidity;
    int cloud;
    int feelslike_c;
    decimal feelslike_f;
    decimal windchill_c;
    decimal windchill_f;
    decimal heatindex_c;
    int heatindex_f;
    decimal dewpoint_c;
    decimal dewpoint_f;
    int vis_km;
    int vis_miles;
    int uv;
    decimal gust_mph;
    decimal gust_kph;
|};

type WeatherData record {|
    Location location;
    Current current;
|};

type WeatherStateInfo record {|
    string basicState;
    int conditionCode;
    string timeOfDay;
    string severity;
|};

type MediatedWeatherResponse record {|
    Location location;
    Current current;
    WeatherStateInfo weatherState;
|};