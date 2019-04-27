import React, { Component }  from 'react';
import { Link } from 'react-router'

import CardTile from '../components/CardTile.js'

class GameplayContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      gameState: null
    }
  }
  
  componentDidMount() {
    let current_game = this.props.params.id
    let backgroundDiv = document.getElementById('overlay') 
    backgroundDiv.classList.add('overlay')
    fetch(`/api/v1/games/${current_game}`)
      .then(response => {
      if (response.ok) {
        return response
      } else {
        let errorMessage = `${response.status} (${response.statusText})`,
          error = new Error(errorMessage)
        throw(error)
      }
    })
    .then(response => response.json())
    .then(body => {
      this.setState({
        gameState: body.gameState
      })
    })
  }
  
  componentWillUnmount() {
    let backgroundDiv = document.getElementById('overlay') 
    backgroundDiv.classList.add('overlay')
  }
  
  render() {
    let statusText
    let renderCards
    if (this.state.gameState === "pending") {
      statusText = "Waiting on Opponent"
      renderCards = <CardTile 
                      role={this.state.gameState}
                    />
    }
    
    return(
      <div>
        <h1>Waiting on Opponent</h1>
        {renderCards}
      </div>
    )
  }
}

export default GameplayContainer
