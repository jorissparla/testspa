module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ viewHeader model
        , case model.currentpage of
            HomePage ->
                div [] [ text "Home Page Information" ]

            AccountsPage ->
                div []
                    [ text "Account List Page"
                    , viewAccounts model
                    ]

            AccountDetails accid ->
                div []
                    [ text ("Account List Page" ++ accid)
                    , viewAccountDetails accid model.accounts
                    ]

            NotFoundPage ->
                div [] [ text "Not Found" ]
        ]


viewHeader model =
    ul []
        [ li [ onClick (NavigatePage HomePage) ] [ text "Home Page" ]
        , li [ onClick (NavigatePage AccountsPage) ] [ text "Accounts" ]
        ]


viewAccounts model =
    div [ class "mdl-grid" ]
        [ div [ class "mdl-cell mdl-cell--12-col" ]
            [ div [ class "", style [ ( "flex", "1 1 auto" ), ( "max-width", "80%" ), ( "min-width", "256px" ), ( "align-items", "center" ), ( "justify-content", "space-between" ), ( "flex-flow", "row wrap" ), ( "display", "flex" ) ] ]
                (model.accounts |> List.map viewAccount)
            ]
        ]


viewAccount : Account -> Html Msg
viewAccount account =
    li [ onClick (NavigatePage (AccountDetails account.uic)) ] [ text account.fullname ]


viewAccountDetails : String -> List Account -> Html Msg
viewAccountDetails accid accounts =
    let
        account =
            (accounts |> List.filter (matchId accid) |> List.head)
    in
        case account of
            Nothing ->
                div [] [ text "Not Found" ]

            Just account ->
                div []
                    [ h2 []
                        [ text ("Account" ++ account.fullname)
                        , div [] [ text account.uic ]
                        ]
                    ]


vac account =
    div []
        [ h2 []
            [ text ("Account" ++ account.fullname)
            , div [] [ text account.uic ]
            ]
        ]


matchId accid account =
    (accid == account.uic)
