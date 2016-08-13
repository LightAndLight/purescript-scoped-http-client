module Node.HTTP.ScopedClient where

import Prelude (($), Unit)
import Control.Monad.Aff (Aff, makeAff)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (Error)
import Node.HTTP (HTTP)
import Node.HTTP.Client (Response)

newtype Result = Result { response :: Response, body :: String }

foreign import data ScopedClient :: *


foreign import create :: forall e. String -> Eff (http :: HTTP | e) ScopedClient

foreign import scope :: forall e. ScopedClient -> String -> (ScopedClient -> Eff e Unit) -> Eff e Unit

foreign import setPath :: forall e. ScopedClient -> String -> Eff (http :: HTTP | e) Unit


foreign import getInternal :: forall e. ScopedClient -> (Error -> Eff e Unit) -> (Result -> Eff e Unit) -> Eff e Unit

get :: forall e. ScopedClient -> Aff (http :: HTTP | e) Result
get client = makeAff $ getInternal client 

foreign import delInternal :: forall e. ScopedClient -> (Error -> Eff e Unit) -> (Result -> Eff e Unit) -> Eff e Unit

del :: forall e. ScopedClient -> Aff (http :: HTTP | e) Result
del client = makeAff $ delInternal client 

foreign import postInternal :: forall e. ScopedClient -> String -> (Error -> Eff e Unit) -> (Result -> Eff e Unit) -> Eff e Unit

post :: forall e. ScopedClient -> String -> Aff (http :: HTTP | e) Result
post client body = makeAff $ postInternal client body Result

foreign import putInternal :: forall e. ScopedClient -> String -> (Response -> String -> Result) -> (Error -> Eff e Unit) -> (Result -> Eff e Unit) -> Eff e Unit

put :: forall e. ScopedClient -> String -> (Response -> String -> Result) -> Aff (http :: HTTP | e) Result
put client body = makeAff $ putInternal client body Result
