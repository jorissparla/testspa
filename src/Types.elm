module Types exposing (..)

import Http


type alias Context =
    { regions : List String
    , teams : List String
    , locations : List String
    }


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
    | SearchTextEntered String
    | EditAccount Account
    | SaveAccount Account
    | FetchAllDone (List Account)
    | FetchAllFail Http.Error
    | FieldChange' FieldChange
    | SaveSuccess Account
    | SaveFail Http.Error


type FieldChange
    = FullName String
    | Email String
    | Region String
    | Location String
    | Team String
    | Login String



{- type AccountMsg
   = SearchTextEntered String
   | EditAccount Account
   | FetchAllDone (List Account)
   | FetchAllFail Http.Error
-}


type alias Account =
    { uic : String
    , login : String
    , navid : String
    , firstname : String
    , lastname : String
    , fullname : String
    , email : String
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
