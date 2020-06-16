# Truckin

Welcome! Truckin is a simple application written in Elixir and utilizing the Phoenix Framework. In addition we use Memento as a wrapper for our in memory distributed database, mnesia. People love food trucks and we should always be ready to scale.

To start it you'll need to clone the repo and then in your cloned directory:

  * Setup the project with `mix setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser, but you won't see much because Truckin is an API based project.

## Endpoints

We currently have a single endpoint that lets you query for food trucks with some options:

```
/trucks
```

### Parameters
`location` allows the our users to pass in their latitude and longitude coordinates and have the returned trucks include a "distance" attribute showing how far away they are from it. Especially useful for quick lunches on launch days  where every minute counts.

`sort_by` allows our users to sort the results. 'distance' is the only currently supported value

`limit` allows our users to limit the number of trucks returned, because decision fatigue is a real thing.

### Example
```
$ curl  -H 'Accept: application/json' "localhost:4000/trucks?location[latitude]=84&location[longitude]=34&sort_by=distance&limit=2"

[
  {
    "address": "900 BEACH ST",
    "applicant": "Bay Area Dots, LLC",
    "facility_type": "Push Cart",
    "food_items": [
      "Hot dogs",
      "condiments",
      "soft pretzels",
      "soft drinks",
      "coffee:cold beverages",
      "pastries",
      "bakery goods",
      "cookies",
      "icecream",
      "candy",
      "soups",
      "churros",
      "chestnuts",
      "nuts",
      "fresh fruit",
      "fruit juices",
      "desserts",
      "potato chips and popcorn."
    ],
    "point": {
      "latitude": 37.8077432884455,
      "longitude": -122.42414994487
    },
    "distance": 6420.688174738894
  },
  {
    "address": "500 FRANCISCO ST",
    "applicant": "Anas Goodies Catering",
    "facility_type": "Truck",
    "food_items": [
      "Cold Truck",
      "Sandwiches",
      "Noodles",
      " Pre-packaged Snacks",
      "Candy",
      "Desserts Various Beverages"
    ],
    "point": {
      "latitude": 37.8050495090589,
      "longitude": -122.41433443694
    },
    "distance": 6420.944768237196
  }
]
```
