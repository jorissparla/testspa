module View exposing (..)

import Html exposing (..)


--import Html.Attributes exposing (..)
---import Html.Events exposing (..)
--import String

import Account.View exposing (..)
import Types exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ viewHeader model
        , case model.currentpage of
            AccountsPage ->
                div []
                    [ searchField
                    , viewAccounts model.accountmodel
                    ]

            AccountDetails accid ->
                div []
                    [ viewAccountDetails accid model.accountmodel.accounts
                    ]

            NotFoundPage ->
                div [] [ text "Not Found" ]
        ]



--viewHeader : Model -> Html Msg


viewHeader model =
    div [] []



{- [ li [ onClick (NavigatePage HomePage) ] [ text "Home Page" ]
   , li [ onClick (NavigatePage AccountsPage) ] [ text "Accounts" ]
-}
