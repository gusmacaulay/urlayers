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
+$  state-zero  [%0 data=json]
::+$  state-zero  [%0 data=json time=@da location=@t timer=(unit @da)]
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
::  ++  on-watch
::    |=  =path
::    ^-  (quip card:agent:gall _this)
::    ~&  'watching, waiting, co-mis er ating no ``'
::    ?:  ?=([%http-response *] path)
::      [~ this]
::      ::`this
::  ?.  =(/ path)
::      (on-watch:def path)
::    ~&  'give nothing watch?'
::    `this

  ::  =/  =json
  ::  [[%give %fact ~ %json !>(*json)]~ this]
  ::
  ++  on-watch
    |=  =path
    ^-  (quip card _this)
    ~&  'the simplest on-watch'
    ~&  path
    ?:  ?=([%http-response *] path)
      [~ this]
    ?.  =(/ path)
    ::  (on-watch:def path)
      ~&  '/ on-watch'
    ::  ~&  (en-json:html data.state)
      :_  this
      [%give %fact ~ %json !>(data)]~
      ::[[%give %fact ~ %json !>(*json)]~ this]
    (on-watch:def path)
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
  ~&  'give it to me baby!'
  :-  [%give %fact ~[/urhack] %json !>(jon)]~
  %=  state
    data  jon
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
  ::    [%'~urhack' %data %geo ~] (en-json:html data.state)
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
--
