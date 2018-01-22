module Updates exposing (update)

import Msgs exposing (Msg)
import Models exposing (Model)
import Ports exposing (toFile)

{-| Before analysing this part of code i highly suggest looking at Model part as it is strongly connected

   Update funcion is basically a core of this app. It takes a Msg and model to convert it into a tuptle.
   By Msg our view funcion lets us know about User's actions. Accordingly we are deleting/adding and creating files.

   Worth mentioning is a fact, that Cmd Msg is only used to pass information to files. If (in future)
   you would like to add new features to this part all you need is to change this Msg.
 -}

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

{-| Because we are using pattern matching in update method we would like to have functions to give us a clear
(and short) result.

filterFirst funcion gives us a filtered List of Strings, but unlike a default funcion List.filter it only takes
first value matched with a "pattern" String and removes it.

first parameter of that funcion is a pattern String to be searched in List, second one is a list itself

Example:
filterFirst "Pattern" ["First","Second","Pattern","Pattern"] -> ["First","Second","Pattern"]

-}

filterFirst : String -> List String -> List String
filterFirst str list = if str == ""
                          then list
                       else if (List.length list) == 0
                         then []
                       else if (List.take 1 list) == [str]
                         then (List.drop 1 list)
                       else List.append (List.take 1 list) (filterFirst str (List.drop 1 list))

{-| We would like to keep track of amount of points we give User for completing tasks. If a List of String-s
contains a certain value 1 point is added. It is due to a fact, that in filterFirst funcion we filter only 1 value out of list

Example:
toAdd ["This","is","List"] "Hello" -> 0
toAdd ["This","is","List"] "List" -> 1
-}
toAdd : List String -> String -> Int
toAdd list str = if List.member str list
                    then 1
                 else 0


{-| Czy my tego gdzies uzywamy? -}
getFirst : String -> List String -> String
getFirst str list = if List.member str list
                      then str
                    else ""

{-| We would like to add a completed task to task history to allow User to keep track of progress
    Function was made primarly for clarity purposes as it is really close to a List.append from libray.
    What is different is checking whether a String is not empty.

    Example:
    appendHistory "Cartoon" ["Tom","Jerry"] -> ["Cartoon","Tom","Jerry"]
-}

appendHistory : String -> List String -> List String
appendHistory str list = if str == ""
                            then list
                          else
                            (List.append list [str])
