module Test.Main where

import Prelude
import Control.Monad.Aff (Aff, launchAff)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE, logShow)
import Control.Monad.Eff.Exception (EXCEPTION)
import Data.Tuple
import Node.HTTP.ScopedClient
import Node.HTTP (HTTP)
import Node.HTTP.Client

test :: forall e. ScopedClient -> Aff (console :: CONSOLE, http :: HTTP | e) Unit
test client = do
    (Tuple res body) <- get client
    liftEff <<< logShow $ statusCode res

main :: Eff (err :: EXCEPTION, http :: HTTP, console :: CONSOLE) Unit
main = do
    client <- create "http://example.com"
    launchAff $ test client
    pure unit
