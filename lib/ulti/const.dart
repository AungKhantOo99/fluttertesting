
/*
    https://api.themoviedb.org/3/movie/346698/credits
    https://api.themoviedb.org/3/person/2201315
    https://api.themoviedb.org/3/person/234352/movie_credits
    https://api.themoviedb.org/3/tv/1396?append_to_response=seasons
    https://api.themoviedb.org/3/person/17419/tv_credits
    https://api.themoviedb.org/3/tv/1396?append_to_response=season/1

 */

const key='eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2ZWU2MTAyMDBiOGVjZWEwOGU0NDNmZmYyNzA4MjBjOSIsInN1YiI6IjY0YjkwYTQ4MzAwOWFhMDBmZmJlZjcyZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.FPN3--Sa_xy7IdprnxQTP9QmyzW4bmZdajZEDkvmWeQ';


// const allList="https://api.themoviedb.org/3/genre/movie/list";
// const mainUrl='https://api.themoviedb.org/3/movie/';
// const moviesDependOnCategory = 'https://api.themoviedb.org/3/discover/movie';
// const searchUrl="https://api.themoviedb.org/3/search/movie";
// const actorDetail='https://api.themoviedb.org/3/person/';

const mainUrl='https://api.themoviedb.org/3';
const allMoviesList="$mainUrl/genre/movie/list";
const allSeriesList="$mainUrl/genre/tv/list";
const moviesDependOnCategory = '$mainUrl/discover/movie';
const seriesDependOnCategory = '$mainUrl/discover/tv';
const searchUrl="$mainUrl/search/movie";
const actorDetail='$mainUrl/person/';