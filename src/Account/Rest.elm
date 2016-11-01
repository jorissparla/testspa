module Account.Rest exposing (..)

import Http
import Json.Decode exposing (..)
import Json.Decode as Decode
import Json.Encode as Encode
import Json.Decode.Pipeline exposing (required, decode)
import Task
import Types exposing (..)


--decodeAccountItem : Decode Account


decodeAccountItem =
    decode Account
        |> required "uic" Decode.string
        |> required "login" Decode.string
        |> required "navid" Decode.string
        |> required "firstname" Decode.string
        |> required "lastname" Decode.string
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


save : Account -> Cmd Msg
save account =
    saveAccount account
        |> Task.perform
            SaveFail
            SaveSuccess



--  |> Cmd.map GetAccountResponse


accountendpoint =
    --"http://nlbavwtls22:3000/api/accounts"
    "http://localhost:3000/api/accounts"


accountEncoder account =
    let
        list =
            [ ( "uic", Encode.string account.uic )
            , ( "login", Encode.string account.login )
            , ( "navid", Encode.string account.navid )
            , ( "firstname", Encode.string account.firstname )
            , ( "lastname", Encode.string account.lastname )
            , ( "fullname", Encode.string account.fullname )
            , ( "email", Encode.string account.email )
            , ( "team", Encode.string account.team )
            , ( "location", Encode.string account.location )
            , ( "region", Encode.string account.region )
            , ( "date_changed", Encode.string account.date_changed )
            , ( "workload", Encode.int account.workload )
            ]
    in
        list |> Encode.object


saveAccount account =
    let
        body =
            accountEncoder account
                |> Encode.encode 4
                |> Http.string
                |> Debug.log "config"

        config =
            { verb = "POST"
            , headers =
                [ ( "Content-Type", "application/json" )
                ]
            , url = accountendpoint
            , body = body
            }
    in
        Http.send Http.defaultSettings config
            |> Http.fromJson decodeAccountItem
