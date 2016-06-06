import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (on)
import Json.Decode as Json exposing ((:=))
import Mouse exposing (Position)


-- #======
-- # name: dragdrop.elm
-- # date: 2016JUN05
-- # desc: example using dragdrop
-- # src : <http://elm-lang.org/examples/drag>
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
    { position : Position
    , drag : Maybe Drag
    }
type alias Drag = 
    { start : Position
    , current : Position
    }


-- INIT
init : ( Model, Cmd Msg )
init = 
    ( Model (Position 200 200) Nothing, Cmd.none)


-- UPDATE
type Msg
   = DragStart Position
   | DragAt Position
   | DragEnd Position

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = 
    (updateHelp msg model, Cmd.none)


updateHelp : Msg -> Model -> Model
updateHelp msg({position, drag} as model) = 
    case msg of 
        DragStart xy ->
            Model position (Just (Drag xy xy))

        DragAt xy ->
            Model position (Maybe.map (\{start} -> Drag start xy) drag)

        DragEnd _->
            Model (getPosition model) Nothing


-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model = 
    case model.drag of 
        Nothing -> 
            Sub.none

        Just _->
            Sub.batch [Mouse.moves DragAt, Mouse.ups DragEnd]


-- VIEW
(=>) = (,)


view : Model -> Html Msg
view model =
  let
    realPosition =
      getPosition model
  in
        div
            [ onMouseDown
            , style
                [ "background-color" => "#0F9"
                , "cursor" => "move"
                , "width" => "50px"
                , "height" => "50px"
                , "border-status" => "2px"
                , "position" => "absolute"
                , "left" => px realPosition.x
                , "top" => px realPosition.y
                , "color" => "black"
                , "display" => "flex"
                , "align-items" => "center"
                , "justify-content" => "center"
                ]
             ]
             [text "☮ ♥ ♬ ⌨"]


px : Int -> String
px number = 
    toString number ++ "px"


getPosition : Model -> Position
getPosition {position, drag} = 
    case drag of
        Nothing ->
            position

        Just {start, current} ->
            Position
                (position.x + current.x - start.x)
                (position.y + current.y - start.y)


onMouseDown : Attribute Msg
onMouseDown = 
    on "mousedown" (Json.map DragStart Mouse.position)



