# CurrencyConversion

To run the app

```bash
mix deps.get
export OPENEXCHANGE_APPID=<your app id>
mix run
```

App will first look for a local cache, if no cache is found, or the local cache is outdated, it will try to fetch from OpenExchangeRates.
