%% This is the application resource file (.app file) for the rserve_websocket,
%% application.
{application, rserve_websocket, 
  [
    {description, "Your Desc HERE"},
    {vsn, "0.1.0"},
    {modules, [
      rserve_websocket_app,
      rserve_websocket_sup,
      rserve_websocket_server
    ]},
    {registered,[rserve_websocket_sup]},
    {applications, [kernel, stdlib, sasl, crypto, rserve, mochiweb, mochiweb_websocket]},
    {mod, {rserve_websocket_app,[]}},
    {start_phases, []}
]}.

