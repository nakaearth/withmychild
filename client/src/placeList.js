import React, { Component } from 'react'
import ReactDOM from 'react-dom'

export class PlaceList extends React.Component {
  constructor(props) {
    console.log('テスト');
    super(props);
    this.state = { places: [] };
  }

  loadPlaceList() {
    $.ajax({
      url: "/api/places/",
      dataType: 'json',
      cache: false,
      success: function(data) {
        this.setState({places: data});
      }.bind(this),
        error: function(xhr, status, err) {
        console.error("/api/places/", status, err.toString());
      }.bind(this)
    });
  }

  componentDidMount() {
    this.loadPlaceList();
  }

  render() {
    return(
      <div class='place_div'>
        ほげ
      </div>
    );
  }
}

export default PlaceList;
