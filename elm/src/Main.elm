module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import List
import String
import Url



-- MAIN


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



-- MODEL


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , name : String
    , words : String
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model key url "" "", Cmd.none )



-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | InputName String
    | InputWords String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url }
            , Cmd.none
            )

        InputName name ->
            ( { model | name = name }, Cmd.none )

        InputWords words ->
            ( { model | words = words }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "EFP-elm"
    , body =
        [ img [ src "/logo.svg" ] []
        , h1 []
            [ text
                ("Exercises for Programmers"
                    ++ (if model.url.path /= "/" then
                            restoreFromLink model.url.path

                        else
                            ""
                       )
                )
            ]
        , if model.url.path == "/" then
            ul []
                (List.indexedMap generateLink
                    [ "Saying Hello"
                    , "Counting the Number of Characters"
                    ]
                )

          else
            blank
        , div []
            [ case model.url.path of
                "/1_Saying_Hello" ->
                    sayingHello model.name

                "/2_Counting_the_Number_of_Characters" ->
                    countingCharacters model.words

                _ ->
                    blank
            ]
        , if model.url.path /= "/" then
            a [ href "/" ] [ text "Back" ]

          else
            blank
        ]
    }



-- PAGE


sayingHello : String -> Html Msg
sayingHello name =
    div []
        [ viewInput "text" "Input your name..." name InputName
        , if name /= "" then
            div [] [ text ("Hello, " ++ name ++ ", nice to meet you!") ]

          else
            blank
        ]


countingCharacters : String -> Html Msg
countingCharacters words =
    div []
        [ viewInput "text" "Input something..." words InputWords
        , if words /= "" then
            let
                len =
                    String.length words
            in
            div []
                [ text
                    ("\""
                        ++ words
                        ++ "\""
                        ++ " has "
                        ++ String.fromInt len
                        ++ " character"
                        ++ (if len == 1 then
                                ""

                            else
                                "s"
                           )
                        ++ "."
                    )
                ]

          else
            blank
        ]



-- COMPONENT


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    input [ type_ t, placeholder p, value v, onInput toMsg ] []



-- UTIL


blank : Html Msg
blank =
    text ""


generateLink : Int -> String -> Html Msg
generateLink index title =
    div []
        [ a
            [ href (String.fromInt (index + 1) ++ "_" ++ String.replace " " "_" title) ]
            [ text (String.fromInt (index + 1) ++ "." ++ title) ]
        ]


restoreFromLink : String -> String
restoreFromLink link =
    String.replace "/" ":" (String.replace "_" " " link)
