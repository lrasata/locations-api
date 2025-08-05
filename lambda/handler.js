const fetch = require("node-fetch");

exports.handler = async (event) => {
    const API_COUNTRIES_GEO_DB_URL = process.env.API_COUNTRIES_GEO_DB_URL;
    const API_CITIES_GEO_DB_URL = process.env.API_CITIES_GEO_DB_URL;

    const dataType = event.queryStringParameters?.dataType;

    const namePrefix = event.queryStringParameters?.namePrefix;

    if (!dataType || !namePrefix) {
        return {
            statusCode: 400,
            body: JSON.stringify({ error: "Missing query parameter" }),
        };
    }

    const urlQuery = `namePrefix=${encodeURIComponent(namePrefix)}&limit=10`;

    const countryCode = event.queryStringParameters?.countryCode;

    let url = "";
    switch (dataType) {
        case "country":
            url = `${API_COUNTRIES_GEO_DB_URL}?${urlQuery}`;
            break;
        case "city":
            if (!countryCode) {
                return {
                    statusCode: 400,
                    body: JSON.stringify({ error: "Missing query parameter for City" }),
                };
            }
            url = `${API_CITIES_GEO_DB_URL}?countryIds=${countryCode}&${urlQuery}`;
            break;
        default:
            return {
                statusCode: 400,
                body: JSON.stringify({ error: "Missing query parameter for DataType" }),
            };
    }


    try {
        const response = await fetch(url, {
            headers: {
                "X-RapidAPI-Host": process.env.GEO_DB_RAPID_API_HOST,
                "X-RapidAPI-Key": process.env.GEO_DB_RAPID_API_KEY,
            },
        });

        if (!response.ok) {
            throw new Error("Error fetching weather data");
        }

        const data = await response.json();

        return {
            statusCode: 200,
            body: JSON.stringify(data),
            headers: { "Content-Type": "application/json" },
        };
    } catch (error) {
        return {
            statusCode: 500,
            body: JSON.stringify({ error: error.message }),
        };
    }
};
