module Msgs exposing (..)

{-| In this application we would like to be able to:
    -Add (a task)
    -Del (a task). This Msg is used while typing a task name in input field and pressing delete
    -DelCheckbox - Delete a task after a user clicks a checkbox near a task name
    -Input - Add input to String in model after a user types something in input field
    -SetGoal - Application has 2 checkboxes. First one is for adding/deleting tasks and second for setting goals.
    Every phrase passed in second box is being converted from String to Int. If it is not possible we give it a default value of 0.
    -}

type Msg =
      Add
      | Del
      | DelCheckbox String
      | Input String
      | SetGoal
      | SendToFile
