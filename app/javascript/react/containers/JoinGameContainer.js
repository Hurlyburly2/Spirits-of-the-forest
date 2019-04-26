import React, { Component }  from 'react';
import { Link } from 'react-router'

import GameTile from '../components/GameTile'

class JoinGameContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
    }
  }
  
  // componentDidMount() {
  //   fetch('/api/v1/games')
  //     .then(response => {
  //     if (response.ok) {
  //       return response
  //     } else {
  //       let errorMessage = `${response.status} (${response.statusText})`,
  //         error = new Error(errorMessage)
  //       throw(error)
  //     }
  //   })
  //   .then(response => response.json())
  //   .then(body => {
  //     this.setState({
  //       myGames: body.games,
  //       currentUser: body.current_user
  //     })
  //   })
  // }
  
  render() {
    let games = "No games have been created"
    // let opponent = ""
    // let games = this.state.myGames.map(game => {
    //   return(
    //     <GameTile
    //       key={game.id}
    //       id={game.id}
    //       current_player={this.currentUser}
    //       opponent={opponent}
    //     />
    //   )
    // })
    
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
