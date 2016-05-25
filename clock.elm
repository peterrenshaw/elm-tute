import Html exposing (..)
import Html.App as App
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time, second)


-- #======
-- # name: clock.elm
-- # date: 2016MAY24
-- # desc: example using SVG 
-- # src : <http://guide.elm-lang.org/architecture/effects/time.html>
-- #=======


-- MAIN
main = 
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL
type alias Model = Time


-- INIT 
init : (Model, Cmd Msg)
init = 
    (0, Cmd.none)


-- UPDATE
type Msg = 
    Tick Time
update : Msg -> Model -> (Model, Cmd Msg)
update action model =
    case action of 
        Tick newTime ->
            (newTime, Cmd.none)


-- VIEW


-- SUBCRIPTIONS


-- FUNCS


