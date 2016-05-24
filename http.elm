
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

update : Msg -> Model -> (Model, Cmd.none)
update msg model = 
    case msg of
        MorePlease ->
            (model, Cmd.none)


-- VIEW
view Model -> Html Msg
view model = 
    div []
        [ h2 [] [text model.topic]
        , img [src model.gifUrl] []
        , button [onClick MorePlease] [text "more please"]
        ]
