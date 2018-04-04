import React, { Component } from 'react'
import { render } from 'react-dom'

class PlaceList extends Component {
  constructor(props) {
    super(props);
    this.state = {
      employees: [],
    };

    this.loadPlaceList = this.loadAjax.bind(this);
  }

  loadPlaceList() {
    return fetch ("/api/places/")
      .then((response) => response.json())
      .then((responseJson) =>
        this.setState({
          places: responseJson.places
        })
      )
      .catch((error) =>
        console.error(error);
      )
  }

  render() {
    return (
      <ul>
        {this.props.items.map((item, index) => (
          <li key={index}>{item}</li>
        ))}
      </ul>
    );
  }
}
