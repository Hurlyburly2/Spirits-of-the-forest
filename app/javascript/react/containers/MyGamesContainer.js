import React, { Component }  from 'react';

import GameTile from '../components/GameTile'

class MyGamesContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      myGames: [],
      currentUser: null
    }
  }
  
  componentDidMount() {
    fetch('/api/v1/games')
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
        myGames: body.games,
        currentUser: body.current_user
      })
    })
  }
  
  // createNewGame() {
  // 
  //   fetch('/api/v1/games', {
  //     method: 'POST',
  //     body: JSON.stringify(newGamePayload)
  //   })
  // }
  
  render() {
    let opponent = "Waiting for Opponent"
    let games = this.state.myGames.map(game => {
      if (game.users[0].id === this.state.currentUser.id) {
        if (game.users[1]) {
          opponent = game.users[1].username
        } else {
          opponent = "Waiting for Opponent"
        }
      } else {
        opponent = game.users[0].username
      }
      if (opponent !== "Waiting for Opponent") {
        opponent = "#{current_player} vs #{opponent}"
      }
      
      return(
        <GameTile
          key={game.id}
          id={game.id}
          current_player={this.currentUser}
          opponent={opponent}
        />
      )
    })
    
    return(
      <div className="gamesContainerPage">
        <h1>MY GAMES</h1>
        <div>{games}</div>
        <ul className="gamesListButtons">
          <a href="#"><li>CREATE NEW GAME</li></a>
          <a href="#"><li>JOIN A GAME</li></a>
          <a href="#"><li>DELETE A GAME</li></a>
        </ul>
      </div>
    )
  }
}

export default MyGamesContainer
