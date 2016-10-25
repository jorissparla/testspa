module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String
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
                    [ searchField
                    , viewAccounts model
                    ]

            AccountDetails accid ->
                div []
                    [ viewAccountDetails accid model.accounts
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
                (model.accounts |> List.filter (matchSearch model.searchText) |> List.map viewAccount)
            ]
        ]


matchSearch : String -> Account -> Bool
matchSearch str account =
    let
        fi =
            account.fullname

        fa =
            account.team

        fo =
            account.location
    in
        String.contains str fi || String.contains str fa || String.contains str fo


searchField =
    div [ class "mdl-grid" ]
        [ div [ class "mdl-cell--1-offset-desktop mdl-cell--3-col-desktop mdl-cell--8-col-tablet mdl-cell" ]
            [ div
                [ class "mdl-textfield mdl-js-textfield" ]
                [ input [ onInput SearchTextEntered, placeholder "Search.", class "mdl-textfield__input", id "sample1", type' "text", style [ ( "left-margin", "30px" ) ] ]
                    []
                ]
            ]
        ]


viewAccount : Account -> Html Msg
viewAccount account =
    div [ onClick (NavigatePage (AccountDetails account.uic)) ]
        [ alternateView account
        ]


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


getFullName name =
    String.append name (String.repeat (100 - (String.length name)) "_") ++ "."


regionColor region =
    case region of
        "EMEA" ->
            "mdl-card mdl-color--light-blue-400 mdl-shadow--2dp"

        "NA" ->
            "mdl-card mdl-color--deep-orange-400 mdl-shadow--2dp"

        "APJ" ->
            "mdl-card mdl-color--green-400 mdl-shadow--2dp"

        "GLB" ->
            "mdl-card mdl-color--red-400 mdl-shadow--2dp"

        _ ->
            "mdl-card mdl-color--purple-400 mdl-shadow--2dp"


getTeam : String -> String
getTeam team =
    if String.isEmpty team then
        "No Team entered"
    else
        team


alternateView : Account -> Html Msg
alternateView accounts =
    div [ class (regionColor accounts.region), style [ ( "min-height", "0px" ), ( "margin", "4px 8px 4px 0px" ), ( "height", "192px" ), ( "width", "220px" ), ( "transition", "box-shadow 250ms ease-in-out 0s" ) ] ]
        [ div [ class "mdl-card__title", style [ ( "align-items", "flex-start" ), ( "flex-direction", "column" ), ( "justify-content", "flex-end" ) ] ]
            [ h1 [ class "mdl-color-text--white mdl-card__title-text", style [ ( "align-self", "flex-start" ) ] ]
                [ text (getFullName accounts.fullname) ]
            ]
        , div [ class "mdl-color-text--white mdl-card__supporting-text" ]
            [ text (getTeam accounts.team) ]
        , div [ class "mdl-color-text--white mdl-card--border mdl-card__actions", style [ ( "align-items", "bottom" ), ( "height", "30px" ), ( "justify-content", "space-between" ), ( "display", "flex" ) ] ]
            [ span [ class "mdl-typography--caption-force-preferred-font-color-contrast", style [ ( "opacity", "0.87" ) ] ]
                [ text accounts.region ]
            , span [ class "mdl-typography--caption-force-preferred-font-color-contrast", style [ ( "opacity", "0.87" ) ] ]
                [ text accounts.location ]
            , button [ class "mdl-js-ripple-effect mdl-js-button mdl-button mdl-button--icon" ]
                [ i [ class "material-icons" ]
                    [ text "edit" ]
                , span [ class "mdl-button__ripple-container" ]
                    [ span [ class "mdl-ripple is-animating" ]
                        []
                    ]
                ]
            , button [ class "mdl-js-ripple-effect mdl-js-button mdl-button mdl-button--icon" ]
                [ i [ class "material-icons" ]
                    [ text "delete" ]
                , span [ class "mdl-button__ripple-container" ]
                    [ span [ class "mdl-ripple is-animating" ]
                        []
                    ]
                ]
            ]
        ]
