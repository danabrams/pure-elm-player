module Main exposing (main)

import Browser
import Html exposing (Attribute, Html, button, div, source, text, video)
import Html.Attributes exposing (autoplay, property, src, width)
import Html.Events exposing (on, onClick)
import Html.Keyed as Keyed
import Json.Decode as Decode
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
    { playState : PlayState
    , videoKey : Int
    }


type PlayState
    = Playing
    | Paused


init : () -> ( Model, Cmd msg )
init _ =
    ( { playState = Paused, videoKey = 0 }, Cmd.none )



-- UPDATE --


type Msg
    = UserClickedPlay
    | UserClickedPause
    | MediaPaused


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        UserClickedPause ->
            ( { model | playState = Paused }, Cmd.none )

        UserClickedPlay ->
            ( { model | playState = Playing }, Cmd.none )

        MediaPaused ->
            ( { model
                | videoKey = model.videoKey + 1
                , playState = Paused
              }
            , Cmd.none
            )



-- VIEW --


view : Model -> Html Msg
view model =
    let
        playPauseBtn =
            case model.playState of
                Playing ->
                    button [ onClick UserClickedPause ] [ text "Pause" ]

                Paused ->
                    button [ onClick UserClickedPlay ] [ text "Play" ]
    in
    div []
        [ Keyed.node "div"
            []
            [ ( String.fromInt model.videoKey
              , video
                    [ autoplay True
                    , muted True
                    , playing model.playState
                    , width 300
                    , onError MediaPaused
                    , onEnded MediaPaused
                    , onAbort MediaPaused
                    ]
                    [ source [ src "https://archive.org/download/CRISSIESHERIDANAnEdisonFilmFrom1897/CRISSIE%20SHERIDAN-An%20Edison%20Film%20from%201897.mp4" ]
                        []
                    ]
              )
            ]
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


onError : Msg -> Attribute Msg
onError tagger =
    on "error" (Decode.succeed tagger)


onEnded : Msg -> Attribute Msg
onEnded tagger =
    on "ended" (Decode.succeed tagger)


onAbort : Msg -> Attribute Msg
onAbort tagger =
    on "abort" (Decode.succeed tagger)
