module Styles exposing (..)

import Html.Attributes exposing (..)
import Html exposing(..)
title : Html.Attribute msg
title =
  style
    [
      ("font-size","400%")
      ,("padding","20px 0")
      ,("text-align","center")
      ]
subtitle : Html.Attribute msg
subtitle =
  style
    [
      ("font-size","200%")
      ,("padding","20px 0")
      ,("text-align","center")
      ]

normal : Html.Attribute msg
normal =
  style
    [
      ("font-size","150%")
      ,("padding","10px 0")
      ,("text-align","center")
    ]

center : Html.Attribute msg
center = style [
      ("font-size","150%")
      ,("text-align","center")]
