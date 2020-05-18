/+  *server, default-agent, verb, dbug
/=  index
  /^  octs
  /;  as-octs:mimes:html
  /:  /===/app/urhack/index
  /|  /html/
      /~  ~
  ==
/=  tile-js
  /^  octs
  /;  as-octs:mimes:html
  /:  /===/app/urhack/js/tile
  /|  /js/
      /~  ~
  ==
/=  script
  /^  octs
  /;  as-octs:mimes:html
  /:  /===/app/urhack/js/index
  /|  /js/
      /~  ~
  ==
/=  style
  /^  octs
  /;  as-octs:mimes:html
  /:  /===/app/urhack/css/index
  /|  /css/
      /~  ~
  ==
/=  urhack-png
  /^  (map knot @)
  /:  /===/app/urhack/img  /_  /png/
::
=,  format
::
|%
+$  card  card:agent:gall
+$  versioned-state
  $%  state-zero
  ==
+$  state-zero  [%0 data=json time=@da location=@t timer=(unit @da)]
--
=|  state-zero
=*  state  -
%+  verb  |
%-  agent:dbug
^-  agent:gall
=<
  |_  bol=bowl:gall
  +*  this      .
      urhack-core  +>
      cc         ~(. urhack-core bol)
      def        ~(. (default-agent this %|) bol)
  ::
  ++  on-init
    ^-  (quip card _this)
    =/  launcha  [%launch-action !>([%add %urhack / '/~urhack/js/tile.js'])]
    :_  this
    :~  [%pass / %arvo %e %connect [~ /'~urhack'] %urhack]
        [%pass /urhack %agent [our.bol %launch] %poke launcha]
    ==
  ::
  ++  on-poke
    |=  [=mark =vase]
    ^-  (quip card _this)
    ~&  'blah'
    =^  cards  state
      ?+    mark  (on-poke:def mark vase)
          %json
        (poke-json:cc !<(json vase))
          %handle-http-request
        =+  !<([eyre-id=@ta =inbound-request:eyre] vase)
        :_  state
        %+  give-simple-payload:app  eyre-id
        %+  require-authorization:app  inbound-request
        poke-handle-http-request:cc
      ==
    [cards this]
  ::
  ++  on-watch
    |=  =path
    ^-  (quip card:agent:gall _this)
    ?:  ?=([%http-response *] path)
      `this
    ?.  =(/ path)
      (on-watch:def path)
    [[%give %fact ~ %json !>(*json)]~ this]
  ::
  ++  on-agent  on-agent:def
  ::
  ++  on-arvo
    |=  [=wire =sign-arvo]
    ^-  (quip card _this)
    ?.  ?=(%bound +<.sign-arvo)
      (on-arvo:def wire sign-arvo)
    [~ this]
  ::
  ++  on-save  on-save:def
  ++  on-load  on-load:def
  ++  on-leave  on-leave:def
  ++  on-peek   on-peek:def
  ++  on-fail   on-fail:def
  --
::
::
|_  bol=bowl:gall
::
++  poke-json
  |=  jon=json
  ^-  (quip card _state)
  ~&  'jokey pokey!'
  ?.  ?=(%s -.jon)
    [~ state]
  =/  str=@t  +.jon
  =/  req=request:http  (request-darksky str)
  =/  out  *outbound-config:iris
  =/  lismov  [%pass /[(scot %da now.bol)] %arvo %i %request req out]~
  ?~  timer
    :-  [[%pass /timer %arvo %b %wait (add now.bol ~h3)] lismov]
    %=  state
      location  str
      timer    `(add now.bol ~h3)
    ==
  [lismov state(location str)]
::
++  request-darksky
  |=  location=@t
  ^-  request:http
  =/  base  'https://api.darksky.net/forecast/634639c10670c7376dc66b6692fe57ca/'
  =/  url=@t  (cat 3 (cat 3 base location) '?units=auto')
  =/  hed  [['Accept' 'application/json']]~
  [%'GET' url hed *(unit octs)]
::
++  http-response
  |=  [=wire response=client-response:iris]
  ^-  (quip card _state)
  ::  ignore all but %finished
  ?.  ?=(%finished -.response)
    [~ state]
  =/  data=(unit mime-data:iris)  full-file.response
  ?~  data
    :: data is null
    [~ state]
  =/  ujon=(unit json)  (de-json:html q.data.u.data)
  ?~  ujon
     [~ state]
  ?>  ?=(%o -.u.ujon)
  ?:  (gth 200 status-code.response-header.response)
    [~ state]
  =/  jon=json  %-  pairs:enjs:format  :~
    currently+(~(got by p.u.ujon) 'currently')
    daily+(~(got by p.u.ujon) 'daily')
  ==
  :-  [%give %fact ~[/weathertile] %json !>(jon)]~
  %=  state
    data  jon
    time  now.bol
  ==
::
++  poke-handle-http-request
  |=  =inbound-request:eyre
  ^-  simple-payload:http
  =+  url=(parse-request-line url.request.inbound-request)
  ?+  site.url  not-found:gen
      [%'~urhack' %css %index ~]  (css-response:gen style)
      [%'~urhack' %js %tile ~]    (js-response:gen tile-js)
      [%'~urhack' %js %index ~]   (js-response:gen script)
  ::
      [%'~urhack' %img @t *]
    =/  name=@t  i.t.t.site.url
    =/  img  (~(get by urhack-png) name)
    ?~  img
      not-found:gen
    (png-response:gen (as-octs:mimes:html u.img))
  ::
      [%'~urhack' *]  (html-response:gen index)
  ==
::
++  wake
  |=  [wir=wire err=(unit tang)]
  ^-  (quip card _state)
  ?~  err
    =/  req/request:http  (request-darksky location)
    =/  out  *outbound-config:iris
    :_  state(timer `(add now.bol ~h3))
    :~  [%pass /[(scot %da now.bol)] %arvo %i %request req out]
        [%pass /timer %arvo %b %wait (add now.bol ~h3)]
    ==
  %-  (slog u.err)
  [~ state]
::
--
