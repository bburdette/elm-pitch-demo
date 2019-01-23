module Main exposing (Model, init)

import Browser
import Element as E exposing (Element)
import Platform exposing (Program)
import Platform.Sub as Sub


type alias Model =
    { title : String }


type Msg
    = Noop


init : Model
init =
    { title = "blah" }


view : Model -> Element Msg
view model =
    E.text "blah"


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> ( init, Cmd.none )
        , view =
            E.layout []
                << view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
