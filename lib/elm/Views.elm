module Views exposing (view)

import Html exposing (..)
import Models exposing (Model)
import Msgs exposing (Msg)
import Updates exposing (update)
import Styles exposing (..)

import Html exposing (div, button, text,input)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (..)

{-| view is a funcion responsible for practically whole user interface.
    It displays notifications, gets input and passes it to update

    To do so we are using a html mpdule from Core, including Html.Events for onCLick or onInput actions and
    Html.Attributes for nicer styling.
-}

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

{-|Function displays checkboxes using HTML.
    Also if a User clicks on a checkbox it sends a Msg to update function to delete certain tasks
 -}
viewCheckbox : String -> Html.Html Msg
viewCheckbox msg =
    div [] [ input [ Html.Attributes.type_ "checkbox", onClick (Msgs.DelCheckbox msg)] []
    , text msg
    ]

{-| Using model this funcion checks if a dayGoal is achieved. -}

checkIfdayGoal : Model -> Bool
checkIfdayGoal model = if model.done >= model.dayGoal
                        then True
                       else
                         False
{-|
  Whole purpose of this app is to motivate an User to complete much more tasks that usually.
  Thats why we would like to display a motivational phrase if a task goal is achieved or User is close to it.
  To generate accurate phrase we use dayGoal and done fields from model.
-}
getCongratulations : Model -> String
getCongratulations model =
                      if model.dayGoal == 0
                        then "Man, be ambitious!"
                      else if (checkIfdayGoal model)
                        then "Congratulations, goal achieved!"
                       else
                         "Keep it up, all you need is " ++ (toString (model.dayGoal - model.done))
