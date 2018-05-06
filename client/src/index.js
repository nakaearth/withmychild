import React, { Component } from 'react'
import ReactDOM from 'react-dom'
import { PlaceList } from './placeList'

const wraper = document.getElementById('placeList');
console.log(wraper);
wraper ? ReactDOM.render(<PlaceList />, wraper) : false;

