module Account.State exposing (..)

import Types exposing (..)


initAccount =
    { uic = ""
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
