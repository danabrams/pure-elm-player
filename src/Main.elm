module Main exposing (main)

import Browser
import Html exposing (Attribute, Html, button, div, source, text, video)
import Html.Attributes exposing (autoplay, property, src, width)
import Html.Events exposing (onClick)
import Json.Encode as Encode



-- MAIN --


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }



-- MODEL --


type alias Model =
    PlayState


type PlayState
    = Playing
    | Paused


init : () -> ( Model, Cmd msg )
init _ =
    ( Paused, Cmd.none )



-- UPDATE --


type Msg
    = UserClickedPlay
    | UserClickedPause


update : Msg -> Model -> ( Model, Cmd msg )
update msg _ =
    case msg of
        UserClickedPause ->
            ( Paused, Cmd.none )

        UserClickedPlay ->
            ( Playing, Cmd.none )



-- VIEW --


view : Model -> Html Msg
view model =
    let
        playPauseBtn =
            case model of
                Playing ->
                    button [ onClick UserClickedPause ] [ text "Pause" ]

                Paused ->
                    button [ onClick UserClickedPlay ] [ text "Play" ]
    in
    div []
        [ video
            [ autoplay True, muted True, playing model, width 300 ]
            [ source [ src "https://archive.org/download/CRISSIESHERIDANAnEdisonFilmFrom1897/CRISSIE%20SHERIDAN-An%20Edison%20Film%20from%201897.mp4" ] [] ]
        , div []
            [ playPauseBtn ]
        ]


muted : Bool -> Attribute msg
muted value =
    property "muted" (Encode.bool value)


playbackRate : Float -> Attribute msg
playbackRate rate =
    property "playbackRate" (Encode.float rate)


playing : PlayState -> Attribute msg
playing state =
    case state of
        Playing ->
            playbackRate 1.0

        Paused ->
            playbackRate 0.0
