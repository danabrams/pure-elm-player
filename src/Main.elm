module Main exposing (main)

import Browser
import Html exposing (Html, source, video)
import Html.Attributes exposing (src)



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
    video []
        [ source [ src "https://archive.org/download/CRISSIESHERIDANAnEdisonFilmFrom1897/CRISSIE%20SHERIDAN-An%20Edison%20Film%20from%201897.mp4" ] []
        ]
