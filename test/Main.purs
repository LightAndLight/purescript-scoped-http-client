module Test.Main where

import Prelude (Unit, bind, ($), (==), (<<<), (<>), unit, pure)
import Control.Monad.Aff (launchAff)
import Control.Monad.Aff.AVar (AVAR)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.Eff.Exception (EXCEPTION)
import Control.Monad.Eff.Timer (TIMER)
import Node.HTTP.ScopedClient
import Node.HTTP (HTTP)
import Node.HTTP.Client (statusCode)
import Test.Unit (suite, test, timeout)
import Test.Unit.Console (TESTOUTPUT)
import Test.Unit.Main (runTest)
import Test.Unit.Assert (assert)

testURL :: String
testURL = "http://httpbin.org"

main :: Eff (err :: EXCEPTION, testOutput :: TESTOUTPUT, timer :: TIMER, avar :: AVAR, http :: HTTP, console :: CONSOLE) Unit
main = runTest do
    suite "requests" do
        test "get" $ timeout 3000 do
            client <- liftEff <<< create $ testURL <> "/get"
            result <- get client
            assert "get status code was not 200" $ statusCode result.response == 200
        test "post" $ timeout 3000 do
            client <- liftEff <<< create $ testURL <> "/post"
            result <- post client "Hello"
            assert "post status code was not 200" $ statusCode result.response == 200
        test "del" $ timeout 3000 do
            client <- liftEff <<< create $ testURL <> "/delete"
            result <- del client
            assert "del status code was not 200" $ statusCode result.response == 200
        test "put" $ timeout 3000 do
            client <- liftEff <<< create $ testURL <> "/put"
            result <- put client "Hello"
            assert "put status code was not 200" $ statusCode result.response == 200

    suite "scope" $ test "get" do
        client <- liftEff $ create testURL
        liftEff $ scope client "get" $ \cli -> do
            launchAff do
                result <- get cli
                assert "get status code was not 200" $ statusCode result.response == 200
            pure unit

