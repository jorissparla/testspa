module State exposing (..)

import Types exposing (..)


initialModel : Model
initialModel =
    { currentpage = HomePage
    , accounts = [ { id = 1, name = "BMW" }, { id = 2, name = "Volkswagen" }, { id = 3, name = "Audi" } ]
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoMsg ->
            ( { model | currentpage = HomePage }, Cmd.none )

        NavigatePage page ->
            ( { model | currentpage = page }, Cmd.none )
