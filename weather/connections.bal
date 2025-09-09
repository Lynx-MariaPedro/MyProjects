import ballerina/http;

final http:Client weatherAPIClient = check new ("https://api.weatherapi.com/v1");
