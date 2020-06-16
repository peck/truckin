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
