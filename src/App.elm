module App exposing (..)

import Html.App exposing (..)
import Types exposing (..)
import State exposing (..)
import View exposing (view)


main : Program Never
main =
    Html.App.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
