module Api where

import Prelude

import Data.Function (on)
import Effect (Effect)
import Effect.Console (log)
import Node.Express.App (App, listenHttp, get)
import Node.Express.Response (send)
import Node.HTTP (Server)

app :: App
app = get "/" $ send "hehehe"

run :: Int -> Effect Server
run port = do
    listenHttp app port \_ ->
        log $ "Listening on " <> show port
