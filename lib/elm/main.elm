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
{-| As we won't need any keyboard/mouse input outside of special checkboxes and input fields we dont need subscriptions

    If you would like to add a special keyboard input or mouse (for example effect when you hover over a field)
    this part will be usefull.

    -}

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none
