module MainTest exposing (suite)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Html exposing (..)
import Html.Attributes as Attr
import Html.Events exposing (..)
import Main exposing (..)
import Test exposing (..)
import Test.Html.Event as Event
import Test.Html.Query as Query
import Test.Html.Selector as Selector


suite : Test
suite =
    describe "Unit Testing: "
        [ describe "Saying Hello"
            [ test "works" <|
                \_ ->
                    sayingHello "Gabriel" |> Query.fromHtml |> Query.contains [ text "Hello, Gabriel, nice to meet you!" ]
            ]
        , describe "Counting the Number of Characters works when"
            [ test "there are multiple letters" <|
                \_ ->
                    countingCharacters "stop"
                        |> Query.fromHtml
                        |> Query.contains [ text "\"stop\" has 4 characters." ]
            , test "there is a single letter" <|
                \_ ->
                    countingCharacters "s"
                        |> Query.fromHtml
                        |> Query.contains [ text "\"s\" has 1 character." ]
            , test "there is no letter" <|
                \_ -> countingCharacters "" |> Query.fromHtml |> Query.hasNot [ Selector.tag "text" ]
            ]
        ]
