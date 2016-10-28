module Account.State exposing (..)

import Types exposing (..)


initAccount =
    { uic = ""
    , fullname = ""
    , team = ""
    , location = ""
    , region = ""
    , date_changed = ""
    , workload = 0
    }


initialModel : AccountModel
initialModel =
    { searchText = ""
    , accounts = []
    , currentaccount = initAccount
    }



--update : Msg -> AccountModel -> ( AccountModel, Cmd Msg )


update msg model =
    case msg of
        EditAccount account ->
            ( { model | currentaccount = account }, Cmd.none )

        FetchAllDone newaccounts ->
            ( { model | accounts = newaccounts }, Cmd.none )

        FetchAllFail error ->
            ( { searchText = "", accounts = model.accounts, currentaccount = initAccount }, Cmd.none )

        SearchTextEntered str ->
            ( { model | searchText = str }, Cmd.none )
