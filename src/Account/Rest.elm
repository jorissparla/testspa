module Account.Rest exposing (..)

import Http
import Json.Decode exposing (..)
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (required, decode)
import Task
import Types exposing (..)


decodeAccountItem =
    decode Account
        |> required "uic" Decode.string
        |> required "login" Decode.string
        |> required "navid" Decode.string
        |> required "fullname" Decode.string
        |> required "email" Decode.string
        |> required "team" Decode.string
        |> required "location" Decode.string
        |> required "region" Decode.string
        |> required "date_changed" Decode.string
        |> required "workload" Decode.int


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
