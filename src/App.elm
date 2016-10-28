module App exposing (..)

import Html.App exposing (..)
import Types exposing (..)
import State exposing (..)
import View exposing (..)


--import Account.State exposing (update)


main : Program Never
main =
    Html.App.program
        { init = init
        , update = update
        , view = View.view
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
