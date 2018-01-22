module Models exposing (init, Model)
import Msgs exposing (Msg)

{-| In this application we would like to keep track of:
    -User's input. By default it is a String
    -List of tasks to be done. It also has a String type
    -Amount of tasks that were done by user
    -User's task goal declared as Int
    -And a history of completed tasks. Analogically to tasks field it is a list of String-s
-}

type alias Model =
  { input : String
  , tasks : List String
  , done : Int
  , dayGoal : Int --default is 3
  , taskHistory : List String
  }

{-| By default we want String containers (tasks and taskHistory) to be empty
    also user havn't done any tasks so done field is 0.
    Also dayGoal is set to 3
-}

model : Model
model =
  Model "" [] 0 3 []

init : (Model, Cmd Msg)
init = (model, Cmd.none)
