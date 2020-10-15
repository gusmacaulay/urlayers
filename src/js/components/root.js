import React, { Component } from 'react';
import { BrowserRouter, Route } from "react-router-dom";
import _ from 'lodash';
import HeaderBar from "./lib/header-bar.js"
import OLMapFragment from "./lib/OLMapFragment.js"

import styled, { ThemeProvider, createGlobalStyle } from 'styled-components';

import light from './themes/light';
import dark from './themes/dark';

import { Text, Box } from '@tlon/indigo-react';


export class Root extends Component {
  constructor(props) {
    super(props);
    this.state = {
      dark: false
    }
    this.updateTheme = this.updateTheme.bind(this);
  }

  updateTheme(updateTheme) {
    this.setState({ dark: updateTheme });
  }

  componentDidMount() {
    this.themeWatcher = window.matchMedia('(prefers-color-scheme: dark)');
    this.setState({ dark: this.themeWatcher.matches });
    this.themeWatcher.addListener(this.updateTheme);
  }

  render() {

    return (
      <BrowserRouter>
        <ThemeProvider theme={this.state.dark ? dark : light}>
        <Box display='flex' flexDirection='column' position='absolute' backgroundColor='white' height='100%' width='100%' px={[0,4]} pb={[0,4]}>
        <HeaderBar/>
        <Route exact path="/~landscapetest" render={ () => {
          return (
            <div className="cf w-100 flex flex-column pa4 ba-m ba-l ba-xl b--gray2 br1 h-100 h-100-minus-40-s h-100-minus-40-m h-100-minus-40-l h-100-minus-40-xl f9 white-d overflow-x-hidden">
              <h1 className="mt0 f8 fw4">urlayers</h1>
              <p className="lh-copy measure pt3">Welcome urlayers.  Click the map to draw a polygon.  Hold shift to freehand draw</p>

      <OLMapFragment />
              </div>
          )}}
        />
        </Box>
        </ThemeProvider>
      </BrowserRouter>
    )
  }
}
