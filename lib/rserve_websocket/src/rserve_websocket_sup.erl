%%%----------------------------------------------------------------
%%% @author  Charlie Sharpsteen <source@sharpsteen.net>
%%% @doc
%%% @end
%%% @copyright 2010 Charlie Sharpsteen
%%%----------------------------------------------------------------
-module(rserve_websocket_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%%===================================================================
%%% API functions
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc
%% Starts the supervisor
%%
%% @spec start_link() -> {ok, Pid} | ignore | {error, Error}
%% @end
%%--------------------------------------------------------------------
start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%%===================================================================
%%% Supervisor callbacks
%%%===================================================================

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Whenever a supervisor is started using supervisor:start_link/[2,3],
%% this function is called by the new process to find out about
%% restart strategy, maximum restart frequency and child
%% specifications.
%%
%% @spec init(Args) -> {ok, {SupFlags, [ChildSpec]}} |
%%                     ignore |
%%                     {error, Reason}
%% @end
%%--------------------------------------------------------------------
init([]) ->
    RestartStrategy = one_for_one,
    MaxRestarts = 1000,
    MaxSecondsBetweenRestarts = 3600,

    SupFlags = {RestartStrategy, MaxRestarts, MaxSecondsBetweenRestarts},

    Restart = permanent,
    Shutdown = 2000,


    MochiIp = case os:getenv("MOCHIWEB_IP") of false -> "0.0.0.0"; Any -> Any end,   
    WebSocketConfig = [{ip, MochiIp}, {port, 80}],
    RserveWebSocket = {rserve_websocket_server, 
      {rserve_websocket_server, start, [WebSocketConfig]},
      Restart, Shutdown, worker, dynamic
    },

    RserveSup = {rserve_Sup, 
      {rserve_sup, start_link, []},
      Restart, Shutdown, supervisor, [rserve_sup]
    },

    {ok, {SupFlags, [RserveWebSocket, RserveSup]}}.

%%%===================================================================
%%% Internal functions
%%%===================================================================


