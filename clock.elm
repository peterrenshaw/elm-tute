import Html exposing (Html)
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
    App.program
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
subscriptions : Model -> Sub Msg
subscriptions model = 
    Time.every second Tick


-- VIEWS
view : Model -> Html Msg
view model = 
    let
        angle = 
            turns (Time.inMinutes model)
        
        handX =
            toString (50 + 40 * cos angle)
        
        handY = 
            toString (50 + 40 * sin angle)
    in
        Svg.svg [ viewBox "0 0 100 100", width "300px" ]
            [ circle [ cx "50", cy "50", r "45", fill "#0B79CE" ] []
            , line [ x1 "50", x2 handX, y2 handY, stroke "#23963" ] []
            ]
