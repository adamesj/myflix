# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tv_comedy = Category.create(
  name: 'TV Comedies'
)

parks = Video.create(
  title: 'Parks and Recreation',
  description: 'Leslie Knope, a midlevel bureaucrat in an Indiana Parks and Recreation Department,
  hopes to beautify her town (and boost her own career) by helping local nurse Ann Perkins
  turn an abandoned construction site into a community park, but what should be a fairly simple
  project is stymied at every turn by oafish bureaucrats, selfish neighbors, governmental red tape
  and a myriad of other challenges.',
  small_cover_url: 'https://assets.fxnetworks.com/cms/prod/shows/parksandrecreation/photos/parks-and-recreation/web/web_largecoverart_series_parksandrecreation.jpg',
  large_cover_url: 'https://suitesculturelles.files.wordpress.com/2015/04/parks-and-rec.jpg',
  category_id: tv_comedy.id
)

Video.create(
  title: "The League",
  description: "Avid fantasy football fans try to balance their time between the league and their real lives.
  It becomes a challenge, though, when the good-natured competition gives way to a win-at-all-costs mentality, which begins to spill over into their relationships and even the workplace.
  It's a cutthroat competition to win the league -- and the bragging rights that come with the feat. The sitcom features a plethora of cameos by real-life NFL players, who play themselves on the series.",
  small_cover_url: 'https://assets.fxnetworks.com/cms/prod/shows/theleague/photos/web_largecoverart_series_the-league_270x398.jpg',
  large_cover_url: 'https://secure.netflix.com/us/boxshots/tv_sdp_s/70157187.jpg',
  category_id: tv_comedy.id
)

Video.create(
  title: "It's Always Sunny in Philadelphia",
  description: "Several friends own Paddy's Pub, a neighborhood bar in Philadelphia, and try to find their way in the world of work and relationships.
  But often, they can't get out of their own way, leading to uncomfortable situations, which usually worsen before improving.
  The gang includes twin siblings Dennis and Sweet Dee Reynolds, along with their longtime friends, Charlie Kelly and Ronald 'Mac' McDonald.",
  small_cover_url: 'https://resizing.flixster.com/tkQIkw13FY9nIkbhGpdgpqjiSe8=/206x305/v1.dDsyMjM0ODM7ajsxNzM3MjsxMjAwOzE2MDA7MjQwMA',
  large_cover_url: 'https://secure.netflix.com/us/boxshots/tv_sdp_s/70136141.jpg',
  category_id: tv_comedy.id
)
