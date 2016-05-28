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
         

-- SUBSCRIPTIONS
subscription : Model -> Sub Msg
subscription model = 
    Time every second Tick


-- VIEWS
view : Model -> HTML Msg
view model = 
    let
        angle = (Time.inMinutes model)
        handX = toString (50 + 40 * cos angle)
        handY = toString (50 + 40 * sin angle)
    in
        Svg [ viewBox "0 0 100 100", width "300px" ]
            [ circle [cx "50", y1 "50", r "45" fill "#0B79CE"][]
             , line [x1 "50", x2 handX, y2 handY stroke "#23963"][]



-- FUNCS


