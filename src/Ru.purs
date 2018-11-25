module Ru where

import Prelude (bind, pure, (#), ($))
import Effect.Aff (Aff, launchAff, joinFiber)
import Affjax (request, defaultRequest)
import Affjax.ResponseFormat as ResponseFormat
import Data.Maybe
import Data.Either (Either(..))
import Data.HTTP.Method (Method(..))
import Cheerio
import Cheerio.Static
import Data.String.Common (split)

type MenuDay = { lunch :: String
             , diner :: String
             , veggie :: String
             , garrison :: String
             , salad :: String
             , dessert :: String 
             }

type Menu = { mon :: MenuDay
            , tue :: MenuDay
            , wed :: MenuDay
            , thu :: MenuDay
            , fri :: MenuDay
            , sat :: MenuDay
             }

menuUrl :: String
menuUrl = "http://proap.ufabc.edu.br/nutricao-e-restaurantes-universitarios/cardapio-semanal"

fetchMenu :: Aff (Maybe String)
fetchMenu = do
    res <- request (defaultRequest { url = menuUrl, method = Left GET, responseFormat = ResponseFormat.string })
    case res.body of
       Left err -> pure $ Nothing
       Right html -> pure $ Just html

parseMenu :: String -> Menu
parseMenu html = 
    { mon:
        { lunch: (parseMenu' 0 0)
        , diner: (parseMenu' 0 1)
        , veggie: (parseMenu' 0 2)
        , garrison: (parseMenu' 0 3)
        , salad: (parseMenu' 0 4)
        , dessert: (parseMenu' 0 5)
        }
    , tue:
        { lunch: (parseMenu' 1 0)
        , diner: (parseMenu' 1 1)
        , veggie: (parseMenu' 1 2)
        , garrison: (parseMenu' 1 3)
        , salad: (parseMenu' 1 4)
        , dessert: (parseMenu' 1 5)
        }
    , wed:
        { lunch: (parseMenu' 2 0)
        , diner: (parseMenu' 2 1)
        , veggie: (parseMenu' 2 2)
        , garrison: (parseMenu' 2 3)
        , salad: (parseMenu' 2 4)
        , dessert: (parseMenu' 2 5)
        }
    , thu:
        { lunch: (parseMenu' 3 0)
        , diner: (parseMenu' 3 1)
        , veggie: (parseMenu' 3 2)
        , garrison: (parseMenu' 3 3)
        , salad: (parseMenu' 3 4)
        , dessert: (parseMenu' 3 5)
        }
    , fri:
        { lunch: (parseMenu' 4 0)
        , diner: (parseMenu' 4 1)
        , veggie: (parseMenu' 4 2)
        , garrison: (parseMenu' 4 3)
        , salad: (parseMenu' 4 4)
        , dessert: (parseMenu' 4 5)
        }
    , sat:
        { lunch: (parseMenu' 5 0)
        , diner: (parseMenu' 5 1)
        , veggie: (parseMenu' 5 2)
        , garrison: (parseMenu' 5 3)
        , salad: (parseMenu' 5 4)
        , dessert: (parseMenu' 5 5)
        }
    }
    where
        parseMenu' day dish = loadRoot html # find ".listagem" # eq day # children # eq dish # text

thisWeek :: Aff (Maybe Menu)
thisWeek = do
    body <- fetchMenu
    case body of
        Nothing -> pure $ Nothing
        Just html -> pure $ Just $ parseMenu html













