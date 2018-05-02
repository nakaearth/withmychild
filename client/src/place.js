import React, { Component } from 'react'
import { render } from 'react-dom'

export class PlaceList extends Component {
  constructor(props) {
    super(props);
    this.state = {
      places: []
    };
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
        console.error(error)
      )
  }

  componentDidMount() {
    this.loadPlaceList();
  }

  render() {
    const place_list = this.state.places.map((place) =>
      <div class='place_div'>
        <span>
          <img src={place.thumb_url} />
          {place.description} <br/>
          投稿日付 #{place.created_at}
          <Link to={'/places/${place.encrypted_id}'} ><button>詳細</button></Link>
        </span>
      </div>
    );

    return (
    { place_list }
    );
  }
}
