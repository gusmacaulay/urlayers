/+  *server, default-agent, dbug
::
|%
+$  card  card:agent:gall
+$  versioned-state
  $%  state-zero
  ==
+$  state-zero  [%0 data=json]
--
=|  state-zero
=*  state  -
%-  agent:dbug
^-  agent:gall
=<
|_  bol=bowl:gall
+*  this      .
    def   ~(. (default-agent this %|) bol)
    cc    ~(. +> bol)

++  on-init
  ^-  (quip card _this)
  =/  launcha  [%launch-action !>([%add %landscapetest [[%basic 'landscapetest' '/~landscapetest/img/tile.png' '/~landscapetest'] %.y]])]
  =/  filea  [%file-server-action !>([%serve-dir /'~landscapetest' /app/landscapetest %.n %.n])]
  :_  this
  :~  [%pass /srv %agent [our.bol %file-server] %poke filea]
      [%pass /landscapetest %agent [our.bol %launch] %poke launcha]
      ==
::
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ~&  'any on-watch '
::  ?:  ?=([%http-response *] path)
::    `this
  ?.  =(/ path)
    ~&  '/ on-watch path'
    :_  this
    [%give %fact ~ %json !>(data)]~
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
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ~&  'on poke!'
  =^  cards  state
    ?+    mark  (on-poke:def mark vase)
        %json
      (poke-json:cc !<(json vase))
    ==
  [cards this]
++  on-save  on-save:def
++  on-load  on-load:def
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-fail   on-fail:def
--
::
::|_  bol=bowl:gall

::
|_  bol=bowl:gall
::
++  poke-json
  |=  jon=json
  ^-  (quip card _state)
  ~&  'in poke-json'
  ~&  jon
  :-  [%give %fact ~[/landscapetest] %json !>(jon)]~
  %=  state
    data  jon
  ==
--
