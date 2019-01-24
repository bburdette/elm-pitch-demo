port module Main exposing (Model, init)

import Browser
import Element as E exposing (Element)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as EI
import Platform exposing (Program)
import Platform.Sub as Sub


type alias Model =
    { pitch : Float }


type Msg
    = DoTheThing
    | Pitch Float
    | Noop


type alias Flags =
    { location : String
    , width : Int
    , height : Int
    }


init : Model
init =
    { pitch = 0
    }


buttonStyle =
    [ Background.color <| E.rgb 0 0 1
    , Font.color <| E.rgb 1 1 1
    , Border.color <| E.rgb 1 0 1
    , E.paddingXY 10 5
    , Border.rounded 3
    ]


view : Model -> Element Msg
view model =
    E.column []
        [ E.text "This only works in Chrome/Chromium as far as I know!"
        , E.row [] [ E.text "pitch: ", E.text (String.fromFloat model.pitch) ]
        , EI.button buttonStyle { label = E.text "do the thing", onPress = Just DoTheThing }
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DoTheThing ->
            ( model, doit () )

        Pitch p ->
            ( { model | pitch = p }, Cmd.none )

        Noop ->
            ( model, Cmd.none )


main : Program Flags Model Msg
main =
    Browser.element
        { init = \_ -> ( init, Cmd.none )
        , view =
            E.layout []
                << view
        , update = update
        , subscriptions = \_ -> pitch Pitch
        }



-- incoming values


port pitch : (Float -> msg) -> Sub msg



-- outgoing values


port doit : () -> Cmd msg
