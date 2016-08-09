module Test.Main where

import Prelude
import Control.Monad.Aff (Aff, launchAff)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE, logShow)
import Control.Monad.Eff.Exception (EXCEPTION, error)
import Control.Monad.Error.Class (throwError)
import Data.Tuple
import Node.HTTP.ScopedClient
import Node.HTTP (HTTP)
import Node.HTTP.Client

test :: forall e. ScopedClient -> Aff (console :: CONSOLE, http :: HTTP | e) Unit
test client = do
    (Tuple res body) <- get client
    if statusCode res == 200
        then pure unit
        else throwError $ error "statusCode was not 200"

main :: Eff (err :: EXCEPTION, http :: HTTP, console :: CONSOLE) Unit
main = do
    client <- create "http://example.com"
    launchAff $ test client
    pure unit
