module Api where

import Prelude

import Data.Function (on)
import Data.Maybe
import Effect (Effect)
import Effect.Console (log)
import Node.Express.App (App, listenHttp, get)
import Node.Express.Response (send)
import Node.Express.Handler (Handler)
import Node.HTTP (Server)
import Effect.Aff.Class (liftAff)

import Simple.JSON  as JSON

import Ru (thisWeek)

clean :: forall a. (JSON.WriteForeign a) => Maybe a -> String
clean (Just t) = JSON.writeJSON t
clean Nothing = ""

ruHandler :: Handler
ruHandler = do
    res <- liftAff $ thisWeek
    send $ clean $ res

app :: App
app = do
    get "/api/v1/ru" ruHandler

run :: Int -> Effect Server
run port = do
    listenHttp app port \_ ->
        log $ "Listening on " <> show port
