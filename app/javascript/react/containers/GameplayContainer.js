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
    let renderCards
    debugger
    
    
    return(
      <div>
        <h1>Waiting on Opponent</h1>
        <CardContainer 
          gameState={this.state.gameState}
        />
      </div>
    )
  }
}

export default GameplayContainer
