module Types exposing (..)


type Page
    = HomePage
    | AccountsPage
    | AccountDetails AccountID
    | NotFoundPage


type alias AccountID =
    Int


type alias Account =
    { id : AccountID
    , name : String
    }


type alias Account0 =
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
    , accounts : List Account
    }


type Msg
    = NavigatePage Page
    | NoMsg
