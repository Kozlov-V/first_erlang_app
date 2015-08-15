-module('firstapp_sup').
-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%% Helper macro for declaring children of supervisor
%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% API functions

start_link() ->
  supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%% Supervisor callbacks

init([]) ->
  lager:info("Supervisor initializing..."),
  Procs = [
           ?CHILD(firstapp_cowboy, worker)
          ],
  {ok, {{one_for_one, 1, 5}, Procs}}.
