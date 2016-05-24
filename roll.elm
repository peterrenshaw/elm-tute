import Html exposing (..)
import Html.App as Html
import Html.Events exposing (..)
import Random


-- #======
-- # name: roll.elm
-- # date: 2016MAY24
-- # desc: example of random plus template for code
-- # src : <http://elm-lang.org/examples/random>
-- #======


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
  { dieFace : Int
  }


init : (Model, Cmd Msg)
init =
  (Model 1, Cmd.none)



-- UPDATE
type Msg
  = Roll
  | NewFace Int


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      (model, Random.generate NewFace (Random.int 1 6))

    NewFace newFace ->
      (Model newFace, Cmd.none)


-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- VIEW
view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ text (toString model.dieFace) ]
    , button [ onClick Roll ] [ text "Roll" ]
    ]
