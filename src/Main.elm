module Main exposing (main)

import Browser
import Html exposing (Attribute, Html, source, video)
import Html.Attributes exposing (autoplay, property, src)
import Json.Encode as Encode



-- MAIN --


main : Program () Model msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }



-- MODEL --


type alias Model =
    ()


init : () -> ( Model, Cmd msg )
init _ =
    ( (), Cmd.none )



-- UPDATE --


update : msg -> Model -> ( Model, Cmd msg )
update _ model =
    ( model, Cmd.none )



-- VIEW --


view : Model -> Html msg
view _ =
    video [ autoplay True, muted True ] [ source [ src "https://archive.org/download/TheGreatTrainRobbery_555/TheGreatTrainRobbery_512kb.mp4" ] [] ]


muted : Bool -> Attribute msg
muted value =
    property "muted" (Encode.bool value)
