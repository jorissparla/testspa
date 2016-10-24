module App exposing (..)

import Html exposing (..)
import Html.App exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type Page
    = HomePage
    | AccountsPage
    | AccountDetails AccountID
    | NotFoundPage


type alias AccountID =
    Int


type alias Account =
    { id : AccountID
    , name : String
    }


type alias Model =
    { currentpage : Page
    , accounts : List Account
    }


type Msg
    = NavigatePage Page
    | NoMsg


initialModel : Model
initialModel =
    { currentpage = HomePage
    , accounts = [ { id = 1, name = "BMW" }, { id = 2, name = "Volkswagen" }, { id = 3, name = "Audi" } ]
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoMsg ->
            ( { model | currentpage = HomePage }, Cmd.none )

        NavigatePage page ->
            ( { model | currentpage = page }, Cmd.none )


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
                    [ text ("Account List Page" ++ toString accid)
                    , viewAccountDetails accid model
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
    li [ onClick (NavigatePage (AccountDetails account.id)) ] [ text account.name ]


viewAccountDetails accid model =
    let
        account =
            (model.accounts |> List.filter (matchId accid) |> List.head)
    in
        case account of
            Nothing ->
                div [] [ text "Not Found" ]

            Just account ->
                div []
                    [ h2 []
                        [ text ("Account" ++ account.name)
                        , div [] [ text (toString account.id) ]
                        ]
                    ]


vac account =
    div []
        [ h2 []
            [ text ("Account" ++ account.name)
            , div [] [ text account.id ]
            ]
        ]


matchId accid account =
    (accid == account.id)
