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
    ( initialModel, getAccounts )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "msg" msg of
        {- EditAccount account ->
           ( { model | currentaccount = account }, Cmd.none )
        -}
        NavigatePage page ->
            ( { model | currentpage = page }, Cmd.none )

        EditAccount account ->
            ( { model | accountmodel = (updateModelAccount account model.accountmodel) }, Cmd.none )

        FetchAllDone newaccounts ->
            ( { model | accountmodel = (updateModelAccounts newaccounts model.accountmodel) }, Cmd.none )

        FetchAllFail error ->
            ( { model | accountmodel = (updateModelSearchText "" model.accountmodel) }, Cmd.none )

        SearchTextEntered str ->
            ( { model | accountmodel = (updateModelSearchText str model.accountmodel) }, Cmd.none )

        FieldChange' sub ->
            case Debug.log "Sub" sub of
                FullName str ->
                    ( updateNameChange2 str model, Cmd.none )

                Email str ->
                    ( updateNameChange2 str model, Cmd.none )

                Region str ->
                    ( updateNameChange2 str model, Cmd.none )

                Team str ->
                    ( updateNameChange2 str model, Cmd.none )

                Location str ->
                    ( updateNameChange2 str model, Cmd.none )


updateNameChange2 : String -> Model -> Model
updateNameChange2 str model =
    let
        accountmodel =
            model.accountmodel

        currentaccount =
            accountmodel.currentaccount
    in
        { model
            | accountmodel =
                { accountmodel
                    | currentaccount =
                        { currentaccount
                            | fullname = str
                        }
                }
        }



--pdateModelAccount : AccountModel -> Account -> AccountModel


updateModelSearchText : String -> AccountModel -> AccountModel
updateModelSearchText str accountmodel =
    { accountmodel | searchText = str }


updateModelAccounts : List Account -> AccountModel -> AccountModel
updateModelAccounts accounts accountmodel =
    { accountmodel | accounts = accounts }


updateModelAccount : Account -> AccountModel -> AccountModel
updateModelAccount account accountmodel =
    { accountmodel | currentaccount = account }
