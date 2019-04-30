import React, { Component }  from 'react';
import { Link } from 'react-router'

import CardTile from '../components/CardTile.js'
import CardContainer from './CardContainer'

class GameplayContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      gameState: null,
      currentUser: null,
      opponent: null
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
      debugger
      this.setState({
        gameState: body.gameState,
        currentUser: body.currentUser,
        opponent: body.opponent
      })
    })
  }
  
  componentWillUnmount() {
    let backgroundDiv = document.getElementById('overlay') 
    backgroundDiv.classList.remove('overlay')
  }
  
  render() {
    let statusText
    let currentPlayerName = ""
    let opponentName = ""
    let message = ""
    
    debugger
    if (this.state.gameState === "play"){
      if (this.state.currentUser && this.state.opponent) {  
        currentPlayerName = this.state.currentUser.username
        opponentName = this.state.opponent.username
        message = `${currentPlayerName} vs ${opponentName}`
      }
    } else if (this.state.gameState === "error") {
      message = "This game is no longer available"
    } else if (this.state.gameState === "pending") {
      message = "Waiting for Opponent..."
    }
    
    
    
    return(
      <div>
        <h1>{message}</h1>
        <CardContainer 
          gameState={this.state.gameState}
        />
      </div>
    )
  }
}

export default GameplayContainer
