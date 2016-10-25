module State exposing (..)

import Types exposing (..)
import Rest exposing (..)


initialModel : Model
initialModel =
    { currentpage = HomePage
    , accounts = []
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, getAccounts )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoMsg ->
            ( { model | currentpage = HomePage }, Cmd.none )

        NavigatePage page ->
            ( { model | currentpage = page }, Cmd.none )

        FetchAllDone newaccounts ->
            ( { model | accounts = newaccounts }, Cmd.none )

        FetchAllFail error ->
            ( { currentpage = model.currentpage, accounts = model.accounts }, Cmd.none )
