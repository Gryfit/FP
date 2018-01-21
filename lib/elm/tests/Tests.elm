module Tests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)

import Updates exposing (update)
import Msgs exposing(..)
import Models exposing (..)
import Ports exposing (..)
suite : Test
suite =
  describe "Simple Tests"
      [ describe "Msgs" -- Nest as many descriptions as you like.
            [ test "check if Added" <|
              \_ -> let
                        m = Model "derp" [] 0 3 []
                        exp = (Model "derp" ["derp"] 0 3 [], Cmd.none)
                    in
                        Expect.equal exp (Updates.update Msgs.Add m)
            , test "check if Input works" <|
              \_ -> let
                        m = Model "" [] 0 3 []
                        el = "derp"
                        exp = (Model "derp" [] 0 3 [], Cmd.none)
                    in
                        Expect.equal exp (Updates.update (Msgs.Input el) m)
            , test "check if Del works" <|
              \_ -> let
                        m = Model "derp" ["derp"] 0 3 []
                        exp = (Model "derp" [] 1 3 ["derp"], Cmd.none)
                    in
                        Expect.equal exp (Updates.update (Msgs.Del) m)
            , test "check if DelCheckbox works" <|
              \_ -> let
                        m = Model "" ["derp"] 0 3 []
                        el = "derp"
                        exp = (Model "" [] 1 3 ["derp"], Cmd.none)
                    in
                        Expect.equal exp (Updates.update (Msgs.DelCheckbox el) m)
            , test "check if SetGoal works" <|
              \_ -> let
                        m = Model "5" [] 0 3 []
                        exp = (Model "" [] 0 5 [], Cmd.none)
                    in
                        Expect.equal exp (Updates.update (Msgs.SetGoal) m)
            , test "check if SendToFile works" <|
              \_ -> let
                        m = Model "" ["derp"] 0 3 []
                        exp = (Model "" ["derp"] 0 3 [], toFile ["derp"])
                    in
                        Expect.equal exp (Updates.update (Msgs.SendToFile) m)

            ]
        ]
