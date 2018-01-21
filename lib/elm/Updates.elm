module Updates exposing (update)

import Msgs exposing (Msg)
import Models exposing (Model)
import Ports exposing (toFile)


update : Msg -> Model ->  ( Model, Cmd Msg )
update msg model=
  case msg of
    Msgs.Del ->
       ((Model model.input (filterFirst model.input model.tasks)
                        (model.done+(toAdd model.tasks model.input)) (model.dayGoal) (appendHistory model.input model.taskHistory))
                        , Cmd.none) --because otherwise 1 delete with no args deletes every task
    Msgs.Add ->
        ((Model model.input (List.append model.tasks [model.input]) model.done (model.dayGoal) model.taskHistory), Cmd.none)
    Msgs.Input str ->
        ((Model str model.tasks model.done (model.dayGoal) model.taskHistory),Cmd.none)
    Msgs.DelCheckbox str ->
        ((Model model.input (filterFirst str model.tasks)
                         (model.done+(toAdd model.tasks str)) (model.dayGoal) (appendHistory str model.taskHistory)) ,Cmd.none)
    Msgs.SetGoal ->
        ((Model "" model.tasks model.done (Result.withDefault 0 (String.toInt model.input)) model.taskHistory),Cmd.none)
    Msgs.SendToFile ->
        (model, toFile  model.tasks)

filterFirst : String -> List String -> List String
filterFirst str list = if str == ""
                          then list
                       else if (List.length list) == 0
                         then []
                       else if (List.take 1 list) == [str]
                         then (List.drop 1 list)
                       else List.append (List.take 1 list) (filterFirst str (List.drop 1 list))

toAdd : List String -> String -> Int
toAdd list str = if List.member str list
                    then 1
                 else 0

getFirst : String -> List String -> String
getFirst str list = if List.member str list
                      then str
                    else ""

appendHistory : String -> List String -> List String
appendHistory str list = if str == ""
                            then list
                          else
                            (List.append list [str])
