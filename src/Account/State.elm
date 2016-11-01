module Account.State exposing (..)

import Types exposing (..)


initAccount =
    { uic = ""
    , login = ""
    , navid = ""
    , firstname = ""
    , lastname = ""
    , fullname = ""
    , email = ""
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
