import React, { Component }  from 'react';
import { Link } from 'react-router'

import GameTile from '../components/GameTile'

class JoinGameContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      currentUser: null,
      currentGameCount: 0,
      pendingGames: [],
      errorMessage: ""
    }
  }
  
  fetchMatches() {
    fetch('/api/v1/matches')
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
      let alertText = ""
      if (body.current_game_count >= 18) {
        alertText = "You cannot have more than 18 games! Please finish or concede some to join others"
      } 
      if (body.games.length == 0) {
        debugger
        alertText = "No other players have created any games."
      }
      this.setState({
        currentUser: body.current_user,
        currentGameCount: body.current_game_count,
        pendingGames: body.games,
        errorMessage: alertText
      })
    })
  }
  
  componentDidMount() {
    this.fetchMatches()
  }
  
  seeMoreMatches() {
    this.fetchMatches()
  }
  
  render() {
    let games
    let clickable = true
    let handleMoreMatches = () => { this.seeMoreMatches() }
    
    if (this.state.currentGameCount >= 18) {
      clickable = false
    }  
    if (this.state.pendingGames.length > 0) {
      games = this.state.pendingGames.map(game => {
        let opponent_text = `vs ${game.users[0].username}`
        return(
          <GameTile
            key={game.id}
            id={game.id}
            current_player={this.state.currentUser}
            opponent={opponent_text}
            clickable={clickable}
          />
        )
      })
    }
    
    return(
      <div className="gamesContainerPage">
        <h1>JOIN A GAME</h1>
        {this.state.errorMessage}
        <div className="gameTileContainer">{games}</div>
        <ul className="gamesListButtons">
          <Link to='/'><li>MY GAMES</li></Link>
          <a href="#" onClick={handleMoreMatches}><li>SEE MORE</li></a>
        </ul>
      </div>
    )
  }
}

export default JoinGameContainer
