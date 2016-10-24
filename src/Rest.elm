module Rest exposing (..)

import Http
import Json.Decode exposing (..)
import Task
import Types exposing (..)


decodeAccountItem : Decoder Account0
decodeAccountItem =
    object7
        Account0
        ("uic" := string)
        ("fullname" := string)
        ("team" := string)
        ("location" := string)
        ("region" := string)
        ("date_changed" := string)
        ("workload" := int)


decodeAccount : Decoder (List Account0)
decodeAccount =
    (list decodeAccountItem)



{- getAccounts =
   Http.get decodeAccount accountendpoint
       |> Task.perform Failed Succeed
       |> Cmd.map GetAccountResponse
-}


accountendpoint =
    "http://nlbavwtls22:3000/api/accounts"
