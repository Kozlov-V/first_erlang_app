%%%-------------------------------------------------------------------
%% @doc firstapp public API
%% @end
%%%-------------------------------------------------------------------

-module('firstapp_app').

-behaviour(application).

%% Application callbacks
-export([start/0
        ,start/2
        ,stop/1]).

%%====================================================================
%% API
%%====================================================================

start() ->
  ok = application:start(crypto),
  ok = application:start(ranch),
  ok = application:start(cowboy),
  ok = application:start(firstapp).

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([
        {'_', [{"/", hello_handler, []}]}
    ]),
    {ok, _} = cowboy:start_http(my_http_listener, 100, [{port, port()}],
        [{env, [{dispatch, Dispatch}]}]
    ),
    'firstapp_sup':start_link().

stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================

port() ->
  case os:getenv("PORT") of
    false -> application:get_env(http_port);
    Port -> list_to_integer(Port)
  end.
