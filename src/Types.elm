module Types exposing (..)

import Http


type Page
    = AccountsPage
    | AccountDetails AccountID
    | NotFoundPage


type alias Model =
    { currentpage : Page
    , accountmodel : AccountModel
    }


type alias AccountID =
    String


type Msg
    = NavigatePage Page
    | AccountMsg' AccountMsg


type AccountMsg
    = SearchTextEntered String
    | EditAccount Account
    | FetchAllDone (List Account)
    | FetchAllFail Http.Error


type alias Account =
    { uic : String
    , fullname : String
    , team : String
    , location : String
    , region : String
    , date_changed : String
    , workload : Int
    }


type alias AccountModel =
    { searchText : String
    , accounts : List Account
    , currentaccount : Account
    }
