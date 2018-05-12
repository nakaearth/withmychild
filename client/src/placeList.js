import React from 'react'
import ReactDOM from 'react-dom'

export class PlaceList extends React.Component {
  constructor(props) {
    super(props);
    console.log('テスト');
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

  componentWillMount() {
    this.loadPlaceList();
  }

  render() {
    return("<div>ほげ</div>");
  }
}
