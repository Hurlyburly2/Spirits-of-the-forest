import React, { Component }  from 'react';
import { Link } from 'react-router'

import GameTile from '../components/GameTile'

class JoinGameContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      currentUser: null,
      pendingGames: []
    }
  }
  
  componentDidMount() {
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
      this.setState({
        currentUser: body.current_user,
        pendingGames: body.games
      })
    })
  }
  
  render() {
    let games = "No games have been created"
    if (this.state.pendingGames.length > 0) {
      games = this.state.pendingGames.map(game => {
        let opponent_text = `vs ${game.users[0].username}`
        return(
          <GameTile
            key={game.id}
            id={game.id}
            current_player={this.state.currentUser}
            opponent={opponent_text}
          />
        )
      })
    }
    
    return(
      <div className="gamesContainerPage">
        <h1>JOIN A GAME</h1>
        <div className="gameTileContainer">{games}</div>
        <ul className="gamesListButtons">
          <Link to='/'><li>MY GAMES</li></Link>
          <a href="#"><li>SEE MORE</li></a>
          <a href="#"><li>DELETE A GAME</li></a>
        </ul>
      </div>
    )
  }
}

export default JoinGameContainer
