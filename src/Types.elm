module Types exposing (..)

import Http


type Page
    = HomePage
    | AccountsPage
    | AccountDetails AccountID
    | NotFoundPage


type alias AccountID =
    String



{- type alias Account =
   { id : AccountID
   , name : String
   }
-}


type alias Account =
    { uic : String
    , fullname : String
    , team : String
    , location : String
    , region : String
    , date_changed : String
    , workload : Int
    }


type alias Model =
    { currentpage : Page
    , searchText : String
    , accounts : List Account
    }


type Msg
    = NavigatePage Page
    | SearchTextEntered String
    | FetchAllDone (List Account)
    | FetchAllFail Http.Error
    | NoMsg
