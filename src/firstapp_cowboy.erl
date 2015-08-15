-module('firstapp_cowboy').
-behaviour(gen_server).

%% Application callbacks
-export([start_link/0]).

%% gen_server callbacks
-export([init/1,
         handle_call/3,
         handle_cast/2,
         handle_info/2,
         terminate/2,
         code_change/3]).

-define(SERVER, ?MODULE).

-record(state, {}).

%% API
start_link() ->
  gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

%% gen_server callbacks
init([]) ->
  Dispatch = cowboy_router:compile([{'_', routes() }]),
  Port = list_to_integer(os:getenv("PORT")),
  lager:info("starting Cowboy server on http://localhost:~b", [Port]),
  {ok, _} = cowboy:start_http(firstapp_http_listener, 100, [{port, Port}],
                               [{env, [{dispatch, Dispatch}]}]
                             ),
  lager:info("Cowboy server started"),
  {ok, #state{}}.

handle_call(_Request, _From, State) ->
  lager:info("Cowboy server handles call"),
  {reply, ok, State}.

handle_cast(_Msg, State) ->
  {noreply, State}.

handle_info(_Info, State) ->
  {noreply, State}.

terminate(_Reason, _State) ->
  lager:info("Cowboy server terminated"),
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

%% Internal functions
routes() ->
  [
    {"/[...]", cowboy_static, {priv_dir, firstapp, <<"www">>}}
  ].
