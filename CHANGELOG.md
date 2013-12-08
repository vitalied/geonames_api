## 0.1.0

### New features:

* When the GeoNames API returns a database or server timeout, your request
  will be retried at most ```GeoNamesAPI.retries``` times. Default is 2, and
  the delay between requests is at most ```GeoNamesAPI.max_sleep_time_between_retries```
  (which defaults to 5 seconds).

* Several endpoints accept multiple param sets, and the order of the parameters
  is not always in the order or priority, so ```find``` and ```all``` and ```where```
  now also accept a parameter hash.

* ```GeoNamesAPI::Hierarchy``` is now an Enumerable of ```GeoName``` instances, as
  all responses will have an ordered set of those entity types.

* URL parameters are properly encoded now.

* For paid users, set ```GeoNamesAPI.token``` and set the ```GeoNamesAPI.url```
  to the ```https``` endpoint.

* Callers can rescue on ```GeoNamesAPI::InvalidParameter``` and ```GeoNamesAPI::InvalidInput``` now.

* GeoNamesAPI.formatted was deleted. The consumer shouldn't care if the JSON response
  was pretty-printed.

* Timezones, AlternateNames, and GeoName entities are encoded as class instances now

