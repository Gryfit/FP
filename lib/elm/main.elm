module Main exposing(main)

--elm-make main.elm --output=main.js

import Views exposing (view)
import Updates exposing (update)
import Models exposing (Model,init)
import Msgs exposing (Msg)
import Html exposing (..)


main : Program Never Model Msg
main =
  Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
      }

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none
