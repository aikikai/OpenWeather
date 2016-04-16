//
//  Constants.swift
//  OpenWeather
//
//  Created by LUCIANO WEHRLI on 15/4/16.
//  Copyright © 2016 LA NACION. All rights reserved.
//

import Foundation

let OPENWEATHER_API_KEY = "efff85170c46a6eef80bc43609c5361f"
let OPENWEATHER_BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"

let citiesCoords : Dictionary<String, Dictionary<String,String>> = ["Berlin": ["lat":"52.5072095", "lon":"13.1442729"],
                                                                    "Madrid": ["lat":"40.4378693", "lon":"-3.8199639"],
                                                                    "Paris": ["lat":"48.8588376", "lon":"2.2773456"],
                                                                    "London": ["lat":"51.5285578", "lon":"-0.2420243"],
                                                                    "NY": ["lat":"40.7053094", "lon":"-74.2588742"] ]