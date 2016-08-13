## Module Node.HTTP.ScopedClient

#### `ScopedClient`

``` purescript
data ScopedClient :: *
```

#### `create`

``` purescript
create :: forall e. String -> Eff (http :: HTTP | e) ScopedClient
```

Create a ScopedClient for a URL

`create "http://example.com"`

#### `scope`

``` purescript
scope :: forall e. ScopedClient -> String -> (ScopedClient -> Eff e Unit) -> Eff e Unit
```

Run operations with a new client that is scoped to a sub-path

```
main = do
     client <- create "http://example.com"
     scope client "example/endpoint" $ \cli -> do
         launchAff $ do
             result <- get cli
             liftEff $ log result.body
         pure unit
``` 

#### `setPath`

``` purescript
setPath :: forall e. ScopedClient -> String -> Eff (http :: HTTP | e) Unit
```

Changes the URL on which the client operates

#### `Result`

``` purescript
type Result = { response :: Response, body :: String }
```

The result of running a request

#### `get`

``` purescript
get :: forall e. ScopedClient -> Aff (http :: HTTP | e) Result
```

#### `del`

``` purescript
del :: forall e. ScopedClient -> Aff (http :: HTTP | e) Result
```

#### `post`

``` purescript
post :: forall e. ScopedClient -> String -> Aff (http :: HTTP | e) Result
```

#### `put`

``` purescript
put :: forall e. ScopedClient -> String -> Aff (http :: HTTP | e) Result
```


