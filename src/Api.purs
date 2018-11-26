module Api where

import Prelude

import Data.Function (on)
import Effect (Effect)
import Effect.Console (log)
import Node.Express.App (App, listenHttp, get)
import Node.Express.Response (send)
import Node.Express.Handler (Handler)
import Node.HTTP (Server)

ruHandler :: Handler
ruHandler = do
    send $ "ajsdkasjd"

app :: App
app = do
    get "/api/v1/ru" ruHandler

run :: Int -> Effect Server
run port = do
    listenHttp app port \_ ->
        log $ "Listening on " <> show port
