-- Read more about this program in the official Elm guide:
-- https://guide.elm-lang.org/architecture/user_input/buttons.html

import Html exposing (beginnerProgram, div, button, text,input)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (style)
--import Console exposing (IO, (>>>), (>>=), forever, getLine, pure, exit, putStrLn)

main =
  beginnerProgram { model = model, update = update, view = view}

type alias Model =
  { input : String
  , tasks : List String
  }
model : Model
model =
  Model "" []

type Msg =
      Add
      | Del
      | DelCheckbox String
      | Input String

update msg model=
  case msg of
    Del ->
       (Model model.input (List.filter (\x-> x/=model.input) model.tasks))

    Add ->
        (Model model.input (List.append model.tasks [model.input]))
    Input str ->
        (Model str model.tasks)
    DelCheckbox str ->
        (Model model.input (List.filter (\x-> x/=str) model.tasks))



view : Model -> Html.Html Msg
view model =
  div []
    [ input [ onInput Input] []
    , button [onClick Add] [text "Add"]
    , button [onClick Del] [text "Delete"]
    , div [style [("padding", "50px")]] (List.map viewCheckbox model.tasks)
    ]

viewMessage : String -> Html.Html msg
viewMessage msg =
  div [] [ text msg ]

viewCheckbox : String -> Html.Html Msg
viewCheckbox msg =
    div [] [ input [ Html.Attributes.type_ "checkbox", onClick (DelCheckbox msg)] []
    , text msg
    ]
