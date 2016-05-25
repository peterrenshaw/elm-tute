import Html exposing (..)
import Html.App exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as json
import Task


-- #======
-- # name: http.elm
-- # date: 2016MAY24
-- # desc: example using HTTP to REST server
-- # src : <http://guide.elm-lang.org/architecture/effects/http.html>
-- #=======



-- MODEL
type alias Model = 
    { topic : String
    , gifUrl : String
    }


-- INIT 
init : (Model, Cmd Msg)
init = 
    (Model "cats", "waiting.gif", Cmd.none)


-- UPDATE
type Msg = MorePlease
         | FetchSucceed String
         | FetchFail Http.Error

update : Msg -> Model -> (Model, Cmd.none)
update msg model = 
    case msg of
        MorePlease ->
            (model, Cmd.none)

        FetchSucceed newUrl ->
            (Model, model.topic newUrl, Cmd.none)

        FetchFail _ ->
            (model, Cmd.none)


-- VIEW
view Model -> Html Msg
view model = 
    div []
        [ h2 [] [text model.topic]
        , img [src model.gifUrl] []
        , button [onClick MorePlease] [text "more please"]
        ]

-- FUNCS
getRandomGif : String -> Cmd Msg
getRandomGif topic = 
    let 
        url = 
            "http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
    in 
        Task.perform FetchFail FethSucceed (Http.get decodeGifUrl url)


decodeGifUrl : Json.Decoder String
decodeGifUrl = 
    Json.at ["data", "image_url"] Json.string
