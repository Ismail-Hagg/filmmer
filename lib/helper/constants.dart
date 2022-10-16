import 'package:flutter/material.dart';



const userDataKey = 'userDataKey';
const orangeColor = Color.fromRGBO(238, 141, 51, 1);
const milkyColor = Color.fromARGB(255, 214, 211, 211);
const mainColor = Color.fromRGBO(48, 48, 48, 1);
const secondaryColor = Color.fromARGB(255, 91, 91, 94);
const blackClor = Colors.black;
const apiKey = 'e11cff04b1fcf50079f6918e5199d691';

const imagebase = 'https://www.themoviedb.org/t/p/w600_and_h900_bestv2';

const upcoming =
    'https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey&language=';
const pop =
    'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=';
const popularTv =
    'https://api.themoviedb.org/3/tv/popular?api_key=$apiKey&language=';
const top =
    'https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey&language=';
const topTv =
    'https://api.themoviedb.org/3/tv/top_rated?api_key=$apiKey&language=';
const search = 'https://api.themoviedb.org/3/search/multi?api_key=$apiKey&language=';
