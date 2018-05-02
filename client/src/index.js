import React, { Component } from 'react'
import { render } from 'react-dom'
import { PlaceList } from './place.js'

render(
  <PlaceList />,
  document.getElementById('placeList')
);
