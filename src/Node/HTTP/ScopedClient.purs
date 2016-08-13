module Node.HTTP.ScopedClient (
    ScopedClient
    , Result(..)
    , create
    , scope
    , setPath
    , get
    , del
    , put
    , post
) where

import Prelude (($), Unit)
import Control.Monad.Aff (Aff, makeAff)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (Error)
import Node.HTTP (HTTP)
import Node.HTTP.Client (Response)

foreign import data ScopedClient :: *

-- | Create a ScopedClient for a URL
-- |
-- | `create "http://example.com"`
foreign import create :: forall e. String -> Eff (http :: HTTP | e) ScopedClient

-- | Run operations with a new client that is scoped to a sub-path
-- |
-- | ```
-- | main = do
-- |      client <- create "http://example.com"
-- |      scope client "example/endpoint" $ \cli -> do
-- |          launchAff $ do
-- |              result <- get cli
-- |              liftEff $ log result.body
-- |          pure unit
-- | ``` 
foreign import scope :: forall e. ScopedClient -> String -> (ScopedClient -> Eff e Unit) -> Eff e Unit

-- | Changes the URL on which the client operates
foreign import setPath :: forall e. ScopedClient -> String -> Eff (http :: HTTP | e) Unit




-- | The result of running a request
type Result = { response :: Response, body :: String }




foreign import getInternal :: forall e. ScopedClient -> (Error -> Eff e Unit) -> (Result -> Eff e Unit) -> Eff e Unit

get :: forall e. ScopedClient -> Aff (http :: HTTP | e) Result
get client = makeAff $ getInternal client




foreign import delInternal :: forall e. ScopedClient -> (Error -> Eff e Unit) -> (Result -> Eff e Unit) -> Eff e Unit

del :: forall e. ScopedClient -> Aff (http :: HTTP | e) Result
del client = makeAff $ delInternal client




foreign import postInternal :: forall e. ScopedClient -> String -> (Error -> Eff e Unit) -> (Result -> Eff e Unit) -> Eff e Unit

post :: forall e. ScopedClient -> String -> Aff (http :: HTTP | e) Result
post client body = makeAff $ postInternal client body




foreign import putInternal :: forall e. ScopedClient -> String -> (Error -> Eff e Unit) -> (Result -> Eff e Unit) -> Eff e Unit

put :: forall e. ScopedClient -> String -> Aff (http :: HTTP | e) Result
put client body = makeAff $ putInternal client body 
