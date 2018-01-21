module Views exposing (view)

import Html exposing (..)
import Models exposing (Model)
import Msgs exposing (Msg)
import Updates exposing (update)
import Styles exposing (..)

import Html exposing (div, button, text,input)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (..)

view : Model -> Html.Html Msg
view model =
  div []
    [
      div [Styles.title] [ text "TO DO LIST" ]
    , div [Styles.normal] [text ("Done today: " ++ toString model.done)]
    , div [Styles.normal] [text (getCongratulations model)]
    , div [Styles.normal] [
            input [type_ "text", placeholder "Add new task",onInput Msgs.Input] []
            , button [onClick Msgs.Add] [text "Add"]
            , button [onClick Msgs.Del] [text "Delete"]
            , button [onClick (Msgs.SendToFile) ][ text "Download" ]]
    , div [Styles.normal] [input [type_ "text", placeholder "Set your day goal!",onInput Msgs.Input] [] , button [onClick Msgs.SetGoal] [text "Set Goal"]]
    , div [Styles.normal] (List.map viewCheckbox model.tasks)
    , div [Styles.subtitle] [text "Done tasks:"]
    , div [Styles.normal] (List.map viewHistory model.taskHistory)
    ]

viewHistory : String -> Html.Html Msg
viewHistory msg = div [] [text msg]

viewCheckbox : String -> Html.Html Msg
viewCheckbox msg =
    div [] [ input [ Html.Attributes.type_ "checkbox", onClick (Msgs.DelCheckbox msg)] []
    , text msg
    ]

checkIfdayGoal : Model -> Bool
checkIfdayGoal model = if model.done >= model.dayGoal
                        then True
                       else
                         False

getCongratulations : Model -> String
getCongratulations model =
                      if model.dayGoal == 0
                        then "Man, be ambitious!"
                      else if (checkIfdayGoal model)
                        then "Congratulations, goal achieved!"
                       else
                         "Keep it up, all you need is " ++ (toString (model.dayGoal - model.done))
