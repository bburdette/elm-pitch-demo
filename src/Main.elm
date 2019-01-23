port module Main exposing (Model, init)

import Browser
import Element as E exposing (Element)
import Element.Input as EI
import Platform exposing (Program)
import Platform.Sub as Sub


type alias Model =
    { title : String, pitch : Float }


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
    { title = "blah"
    , pitch = 0
    }


view : Model -> Element Msg
view model =
    E.column []
        [ E.row [] [ E.text "pitch: ", E.text (String.fromFloat model.pitch) ]
        , EI.button [] { label = E.text "do the thing", onPress = Just DoTheThing }
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DoTheThing ->
            ( model, time 42 )

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


port time : Float -> Cmd msg



{-
      // <script type="text/javascript" src="static/pitchdetect.js"></script>
   From JS, you talk to these ports like this:

   var app = Elm.Example.init();

   app.ports.prices.send(42);
   app.ports.prices.send(13);

   app.ports.time.subscribe(callback);
   app.ports.time.unsubscribe(callback);
-}
