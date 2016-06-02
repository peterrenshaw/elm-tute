import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Websocket


-- #======
-- # name: chat.elm
-- # date: 2016JUN02
-- # desc: example using websockets
-- # src : <http://guide.elm-lang.org/architecture/effects/web_sockets.html>
-- #=======



-- MAIN
main = 
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


-- MODEL
type alias Model = 
    { input : String
    , messages : List String
    }


-- INIT
init : (Model, Cmd Msg)
init = 
    (Model "" [], Cmd.none)


-- UPDATE
type Msg 
    = Input String
    | Send
    | NewMessage String


update : Msg -> Model -> (Model, Cmd Msg)
update msg {input, messags} = 
    case msg of 
        Input newInput ->
            (Model newInput messages, Cmd.none)

        Send ->
            (Model "" messages, Websocket.send "ws://echo.websocket.org" input)

        NewMessage str ->
            (Model input (str :: messages), Cmd.none)


-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model = 
    Websocket.listen "ws://echo.websocket.org" NewMessage


-- VIEW
view : Model -> Html Msg
view model = 
    div []
        [ div [] (List.map viewMessage model.messages)
        , input [onInput Input] []
        , button [onClick Send] [text "Send"]
        ]


-- FUNCS
viewMessage : String -> Html msg
viewMessage msg = 
    div [] [text msg]


