import React, { Component } from 'react';
import { BrowserRouter, Route } from "react-router-dom";
import _ from 'lodash';
import { HeaderBar } from "./lib/header-bar.js"
import OLMapFragment from './lib/OLMapFragment.js'

export class Root extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <BrowserRouter>
        <div className="absolute h-100 w-100 bg-gray0-d ph4-m ph4-l ph4-xl pb4-m pb4-l pb4-xl">
        <HeaderBar/>
        <Route exact path="/~urhack" render={ () => {
          return (
            <div className="cf w-100 flex flex-column pa4 ba-m ba-l ba-xl b--gray2 br1 h-100 h-100-minus-40-s h-100-minus-40-m h-100-minus-40-l h-100-minus-40-xl f9 white-d overflow-x-hidden">
              <h1 className="mt0 f8 fw4">urlayers</h1>
              <p className="lh-copy measure pt3">Welcome urlayers.  Click the map to draw a polygon.  Hold shift to freehand draw</p>

      <OLMapFragment />
              </div>
          )}}
        />
          </div>
      </BrowserRouter>
    )
  }
}
