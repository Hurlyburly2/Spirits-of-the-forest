import React, { Component }  from 'react';
import { Link } from 'react-router'

import GameTile from '../components/GameTile'
import ProfilePic from '../components/ProfilePic'

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
      let alertText = ""
      if (body.current_game_count >= 18) {
        alertText = "You cannot have more than 18 games! Please finish or concede some to join others"
      } 
      if (body.games.length == 0) {
        alertText = "No other players have created any games."
      }
      this.setState({
        currentUser: body.currentUser,
        currentGameCount: body.current_game_count,
        pendingGames: body.games,
        errorMessage: alertText
      })
    })
  }
  
  componentDidMount() {
    this.fetchMatches()
  }
  
  seeMoreMatches(event) {
    this.fetchMatches()
  }
  
  render() {
    let games
    let clickable = true
    let handleMoreMatches = () => { this.seeMoreMatches() }
    let profilePic
    
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
            current_player="unknown"
            opponent={opponent_text}
            opponentPic={game.users[0].which_profile_pic}
            opponentRank={game.users[0].rank}
            whose_turn="unknown"
            clickable={clickable}
          />
        )
      })
    }
    
    if (this.state.currentUser) {
      profilePic = <ProfilePic key="ProfilePic" whichPic={this.state.currentUser.which_profile_pic} whichRank={this.state.currentUser.rank} where="GamePage" who="player"/>
    }
    
    let errorBox = null
    if (this.state.errorMessage !== "") {
      errorBox = <div id="joinErrorMessage">{this.state.errorMessage}</div>
    }
    
    return(
      <div className="gamesContainerPage">
        <div className="gamesContainerNav">
          <div className = "gamesContainerNav-partone">
            {profilePic}
            <div className="gamesContainer-myGames">
              <ul className="gamesListButtons">
                  <li id="gamesListMyGames">Join a Game</li>
                  <Link to='/'><li id="gamesListCreate">My Games</li></Link>
                  <a href="#" onClick={handleMoreMatches}><li id="gamesListJoin">See More</li></a>
              </ul>
            </div>
          </div>
        </div>
        {errorBox}
        <div className="gameTileContainer">{games}</div>
      </div>
    )
  }
}

export default JoinGameContainer

// <div className="gamesContainerPage">
//   <h1>JOIN A GAME</h1>
//   {this.state.errorMessage}
//   <div className="gameTileContainer">{games}</div>
//   <ul className="gamesListButtons">
//     <Link to='/'><li>MY GAMES</li></Link>
//     <a href="#" onClick={handleMoreMatches}><li>SEE MORE</li></a>
//   </ul>
// </div>
