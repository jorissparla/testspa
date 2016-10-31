module Account.Rest exposing (..)

import Http
import Json.Decode exposing (..)
import Task
import Types exposing (..)


decodeAccountItem : Decoder Account
decodeAccountItem =
    object8
        Account
        ("uic" := string)
        ("fullname" := string)
        ("email" := string)
        ("team" := string)
        ("location" := string)
        ("region" := string)
        ("date_changed" := string)
        ("workload" := int)


decodeAccount : Decoder (List Account)
decodeAccount =
    (list decodeAccountItem)


getAccounts : Cmd Msg
getAccounts =
    Http.get decodeAccount accountendpoint
        |> Task.perform FetchAllFail FetchAllDone



--  |> Cmd.map GetAccountResponse


accountendpoint =
    --"http://nlbavwtls22:3000/api/accounts"
    "http://localhost:3000/api/accounts"
