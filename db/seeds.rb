# Seed the RottenPotatoes DB with some movies.
more_movies = [
  {
    title: 'Aladdin',
    rating: 'G',
    release_date: '25-Nov-1992',
    director: 'John Musker'
  },
  {
    title: 'When Harry Met Sally',
    rating: 'R',
    release_date: '21-Jul-1989',
    director: 'Rob Reiner'
  },
  {
    title: 'The Help',
    rating: 'PG-13',
    release_date: '10-Aug-2011',
    director: 'Tate Taylor'
  },
  {
    title: 'Raiders of the Lost Ark',
    rating: 'PG',
    release_date: '12-Jun-1981',
    director: 'Steven Spielberg'
  }
]

more_movies.each do |movie|
  Movie.create!(movie)
end
