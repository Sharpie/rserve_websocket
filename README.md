# Rserve: WebSocket

This is an Erlang application that exposes Rserve to the outside world
through a WebSocket interface.  It uses another application, [Rserve:
Erlang][1] to manage binary communication with Rserve.  The WebSocket
interface is provided by a Mochiweb add-on [Mochiweb: Websocket][2]
which was originally written by [Dave Bryson][3].

The WebSocket server is curretly very rudimentary and needs better
support for configuration and logging.  It can be compiled using the
[Sinan][4] build tool and installed with the [Faxien][5] package manager:

    sinan build
    sinan dist
    faxien ir

There may also be some whining by the build tools if you are not using
Erlang R14A.

  [1]: http://github.com/Sharpie/rserve_erl
  [2]: http://github.com/Sharpie/mochiweb_websocket
  [3]: http://github.com/davebryson/erlang_websocket
  [4]: http://github.com/erlware/sinan
  [5]: http://github.com/erlware/faxien
