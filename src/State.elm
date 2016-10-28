module State exposing (..)

import Types exposing (..)
import Account.Rest exposing (..)
import Account.State exposing (..)


initAccount =
    { uic = ""
    , fullname = ""
    , team = ""
    , location = ""
    , region = ""
    , date_changed = ""
    , workload = 0
    }


initialModel : Types.Model
initialModel =
    { currentpage = AccountsPage
    , accountmodel = Account.State.initialModel
    }


init : ( Types.Model, Cmd Msg )
init =
    ( initialModel, Cmd.map AccountMsg' getAccounts )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        {- EditAccount account ->
           ( { model | currentaccount = account }, Cmd.none )
        -}
        NavigatePage page ->
            ( { model | currentpage = page }, Cmd.none )

        AccountMsg' msg ->
            case msg of
                EditAccount account ->
                    ( { model | accountmodel = (updateModelAccount account model.accountmodel) }, Cmd.none )

                FetchAllDone newaccounts ->
                    ( { model | accountmodel = (updateModelAccounts newaccounts model.accountmodel) }, Cmd.none )

                FetchAllFail error ->
                    ( { model | accountmodel = (updateModelSearchText "" model.accountmodel) }, Cmd.none )

                SearchTextEntered str ->
                    ( { model | accountmodel = (updateModelSearchText str model.accountmodel) }, Cmd.none )



--pdateModelAccount : AccountModel -> Account -> AccountModel


updateModelSearchText str accountmodel =
    { accountmodel | searchText = str }


updateModelAccounts accounts accountmodel =
    { accountmodel | accounts = accounts }


updateModelAccount account accountmodel =
    { accountmodel | currentaccount = account }



--Account.State.update msg model.accountmodel
{-
   FetchAllDone newaccounts ->
       ( { model | accounts = newaccounts }, Cmd.none )

   FetchAllFail error ->
       ( { currentpage = model.currentpage, searchText = "", accounts = model.accounts, currentaccount = initAccount }, Cmd.none )

   SearchTextEntered str ->
       ( { model | searchText = str }, Cmd.none )
-}
