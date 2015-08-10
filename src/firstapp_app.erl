%%%-------------------------------------------------------------------
%% @doc firstapp public API
%% @end
%%%-------------------------------------------------------------------

-module('firstapp_app').

-behaviour(application).

%% Application callbacks
-export([start/2
        ,stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([
        {'_', [{"/", hello_handler, []}]}
    ]),
    Port = list_to_integer(os:getenv("PORT")),
    {ok, _} = cowboy:start_http(my_http_listener, 100, [{port, Port}],
        [{env, [{dispatch, Dispatch}]}]
    ),
    'firstapp_sup':start_link().

stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
