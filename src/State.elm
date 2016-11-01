module State exposing (..)

import Types exposing (..)
import Account.Rest exposing (..)
import Account.State exposing (..)
import Update.Extra


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
            case page of
                AccountDetails str ->
                    let
                        theaccount =
                            model.accountmodel.accounts |> List.filter (\a -> a.uic == str) |> List.head
                    in
                        case theaccount of
                            Nothing ->
                                ( { model | currentpage = page }, Cmd.none )

                            Just theaccount ->
                                ( { model | currentpage = page, accountmodel = (updateModelAccount theaccount model.accountmodel) }, Cmd.none )

                _ ->
                    ( { model | currentpage = page }, Cmd.none )

        EditAccount account ->
            ( { model | accountmodel = (updateModelAccount account model.accountmodel) }, Cmd.none )

        FetchAllDone newaccounts ->
            ( { model | accountmodel = (updateModelAccounts newaccounts model.accountmodel) }, Cmd.none )

        FetchAllFail error ->
            ( { model | accountmodel = (updateModelSearchText "" model.accountmodel) }, Cmd.none )

        SaveAccount account ->
            ( model, updateCurrentAccountDetails model.accountmodel )

        SaveSuccess account ->
            ( { model | accountmodel = (updateModelAccount account model.accountmodel) }, Cmd.none )

        SaveFail error ->
            ( { model | accountmodel = (updateModelSearchText "" model.accountmodel) }, Cmd.none )

        SearchTextEntered str ->
            ( { model | accountmodel = (updateModelSearchText str model.accountmodel) }, Cmd.none )

        FieldChange' sub ->
            case Debug.log "Sub" sub of
                FullName str ->
                    ( updateFullName str model, Cmd.none )

                Email str ->
                    ( updateEmail str model, Cmd.none )

                Region str ->
                    ( updateRegion str model, Cmd.none )

                Team str ->
                    ( updateTeam str model, Cmd.none )

                Location str ->
                    ( updateLocation str model, Cmd.none )

                Login str ->
                    ( updateLogin str model, Cmd.none )


updateCurrentAccountDetails : AccountModel -> Cmd Msg
updateCurrentAccountDetails accmodel =
    let
        theaccount =
            accmodel.currentaccount |> Debug.log "theaccount"
    in
        save theaccount


updateLogin : String -> Model -> Model
updateLogin str model =
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
                            | login = str
                        }
                }
        }


updateFullName : String -> Model -> Model
updateFullName str model =
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


updateEmail : String -> Model -> Model
updateEmail str model =
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
                            | email = str
                        }
                }
        }


updateRegion : String -> Model -> Model
updateRegion str model =
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
                            | region = str
                        }
                }
        }


updateTeam : String -> Model -> Model
updateTeam str model =
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
                            | team = str
                        }
                }
        }


updateLocation : String -> Model -> Model
updateLocation str model =
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
                            | location = str
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
    let
        theAccount =
            account |> Debug.log "Editaccount"
    in
        { accountmodel | currentaccount = account }
