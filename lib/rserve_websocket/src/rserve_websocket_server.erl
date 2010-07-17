%%
%% Simple Echo example
%% @author Dave Bryson [http://weblog.miceda.org]
%%
-module( rserve_websocket_server ).

-export([ start/1, stop/0, loop/1 ]).

-define( SERVER, ?MODULE ).

start(Options) ->
  Loop = fun ( WebSocket ) ->
    ?SERVER:loop( WebSocket )
  end,
  mochiweb_websocket:start( [{name, ?SERVER}, {loop, Loop} | Options] ).

stop() ->
  mochiweb_websocket:stop( ?SERVER ).


loop( WebSocket ) ->
  %% Get the data sent from the client
  Data = WebSocket:get_data(),

  Response = rserve_server:eval( Data ),
  WebSocket:send( Response ).
    
