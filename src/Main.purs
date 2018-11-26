module Main where

import Prelude

import Api (run)
import Control.Promise (Promise)
import Control.Promise as Promise
import Effect (Effect)
import Effect.Console (log)
import Effect.Aff (launchAff)
import Effect.Class (liftEffect)
import Data.Maybe
import Node.HTTP (Server)
import Ru (Menu, thisWeek)

--main :: Effect Server
main = do
    run 8080 
