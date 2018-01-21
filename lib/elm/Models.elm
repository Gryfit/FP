module Models exposing (init, Model)
import Msgs exposing (Msg)
type alias Model =
  { input : String
  , tasks : List String
  , done : Int
  , dayGoal : Int --default is 3
  , taskHistory : List String
  }
model : Model
model =
  Model "" [] 0 3 []
init : (Model, Cmd Msg)
init = (model, Cmd.none)
