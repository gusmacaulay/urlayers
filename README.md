urlayers
========

urlayers is an openlayers integration and geojson datastore for urbit. Built with create-landscape-app.

demo video - https://www.youtube.com/watch?v=AH1nI_OWaco

<img src="/screens/urlayers.png" >

## Features

* openlayers client 
* geojson storage ... clunky, but it works
* versioning ... wishlist
* data sharing ... wishlist

## Install and Run

Based on create-landscape-app, so;

* npm install
* edit the .urbitrc file to point at your ship
* npm run build
* |commit %desk
* |start %urhack

## Usage

Draw geojson features, reload the page ... data persists, Ctrl-D your ship, restart ... data persists!

## About/Motivation

The intention behind urlayers, is to experiment with and demo urbits storage, json and network sharing capabilities (presently the demo does none of these things).  In the geospatial world, there are various optimised solutions for data processing,querying etc. whilst data management, versioning, permissions and sharing are often fraught and troublesome.  In the urbit world, data querying aspect of database is not available (yet?), this project is an attempt to build on urbits strength and demonstrate data versioning and sharing functionality ... so far this is aspirational.

~lomped-firser
