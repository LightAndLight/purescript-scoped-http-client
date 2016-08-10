module Test.Main where

import Prelude
import Control.Monad.Aff (Aff, launchAff)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE, log, logShow)
import Control.Monad.Eff.Exception (EXCEPTION, error)
import Control.Monad.Error.Class (throwError)
import Data.Tuple
import Node.HTTP.ScopedClient
import Node.HTTP (HTTP)
import Node.HTTP.Client

doGet :: forall e. ScopedClient -> Aff (console :: CONSOLE, http :: HTTP | e) Unit
doGet client = do
    result <- get client
    liftEff $ log result.body
    liftEff <<< logShow $ statusCode result.response

doPost :: forall e. ScopedClient -> Aff (console :: CONSOLE, http :: HTTP | e) Unit
doPost client = do
    result <- post client "Hello"
    liftEff $ log result.body
    liftEff <<< logShow $ statusCode result.response

doDel :: forall e. ScopedClient -> Aff (console :: CONSOLE, http :: HTTP | e) Unit
doDel client = do
    result <- del client
    liftEff $ log result.body
    liftEff <<< logShow $ statusCode result.response

doPut :: forall e. ScopedClient -> Aff (console :: CONSOLE, http :: HTTP | e) Unit
doPut client = do
    result <- put client "Hello"
    liftEff $ log result.body
    liftEff <<< logShow $ statusCode result.response

main :: Eff (err :: EXCEPTION, http :: HTTP, console :: CONSOLE) Unit
main = do
    client <- create "http://httpbin.org"
    log "Testing get request"
    scope client "get" $ \cli -> do
        launchAff $ doGet cli
        pure unit
    log "Testing post request"
    scope client "post" $ \cli -> do
        launchAff $ doPost cli
        pure unit
    log "Testing put request"
    scope client "put" $ \cli -> do
        launchAff $ doPut cli
        pure unit
    log "Testing del request"
    scope client "delete" $ \cli -> do
        launchAff $ doDel cli
        pure unit
