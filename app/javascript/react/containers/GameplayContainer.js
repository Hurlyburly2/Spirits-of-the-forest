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
        opponent: body.opponent,
        cards: JSON.parse(body.cards)
      })
    })
  }
  
  componentWillUnmount() {
    let backgroundDiv = document.getElementById('overlay') 
    backgroundDiv.classList.remove('overlay')
  }
  
  deleteGame () {
    let game_id = this.props.params.id
    fetch(`/api/v1/games/${game_id}`, {
      credentials: 'same-origin',
      method: 'DELETE',
      body: JSON.stringify(game_id),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      }
    })
    .then(response => {
        if (response.ok) {
          return response;
        } else {
          let errorMessage = `${response.status} (${response.statusText})`,
              error = new Error(errorMessage);
          throw(error);
        }
      })
      .then(response => response.json())
      .then(body => {
        return window.location.href = "/"
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`));
  }
  
  render() {
    let statusText
    let currentPlayerName = ""
    let opponentName = ""
    let message = ""
    let endGame = ""
    let handleDeleteGame = () => { this.deleteGame() }
    
    if (this.state.gameState === "play"){
      if (this.state.currentUser && this.state.opponent) {  
        currentPlayerName = this.state.currentUser.username
        opponentName = this.state.opponent.username
        message = `${currentPlayerName} vs ${opponentName}`
      }
      endGame = "CONCEDE"
    } else if (this.state.gameState === "error") {
      message = "This game is no longer available"
    } else if (this.state.gameState === "pending") {
      message = "Waiting for Opponent..."
      endGame = "DELETE GAME"
    }
    
    return(
      <div className="gamesContainerPage">
        <h1>{message}</h1>
        <CardContainer 
          gameState={this.state.gameState}
          cards={this.state.cards}
        />
        <ul className="gamePlayButtons">
          <Link to='/'><li>MY GAMES</li></Link>
          <li onClick={handleDeleteGame}>{endGame}</li>
        </ul>
      </div>
    )
  }
}

export default GameplayContainer
