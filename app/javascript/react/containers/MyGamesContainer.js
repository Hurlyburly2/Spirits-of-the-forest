import React, { Component }  from 'react';
import { Link } from 'react-router'

import GameTile from '../components/GameTile'
import ProfilePic from '../components/ProfilePic'
import GameTypeTile from '../components/GameTypeTile'

class MyGamesContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      myGames: [],
      currentUser: null,
      errorMessage: "",
      newGameType: null
    }
    this.handleNewGame = this.handleNewGame.bind(this)
    this.createNewGame = this.createNewGame.bind(this)
    this.handleClickTile = this.handleClickTile.bind(this)
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
        currentUser: body.currentUser
      })
    })
  }
  
  createNewGame() {
    let newGamePayload = {
      user: this.state.currentUser,
      gameType: "long"
    }
    fetch('/api/v1/games', {
      method: 'POST',
      body: JSON.stringify(newGamePayload),
      credentials: 'same-origin'
    })
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
          myGames: this.state.myGames.concat(body.games),
          newGameType: null
        })
      })
  }
  
  handleNewGame() {
    if (this.state.myGames.length < 18) {
      switch (this.state.newGameType) {
        case null:
          this.setState({
            newGameType: "makingSelection"
          })
          break;
        case "makingSelection":
          this.createNewGame()
          break;
      }
    } else {
      this.setState({
        errorMessage: "You cannot have more than 18 games! Please finish games or concede to create more"
      })
    }
  }
  
  handleClickTile(event) {
  }
  
  render() {
    let opponent = "Waiting for Opponent"
    let opponentPic = ""
    let opponentRank = ""
    let profilePic;
    let selectGameType;
    
    if (this.state.newGameType == "makingSelection") {
      selectGameType = <GameTypeTile />
    }
    
    let games = this.state.myGames.map(game => {
      if (game.users[0].id === this.state.currentUser.id) {
        if (game.users[1]) {
          opponent = game.users[1].username
          opponentPic = game.users[1].which_profile_pic
          opponentRank = game.users[1].rank
        } else {
          opponent = "Waiting for Opponent"
          opponentPic = "unknown"
          opponentRank = "unknown"
        }
      } else {
        opponent = game.users[0].username
        opponentPic = game.users[0].which_profile_pic
        opponentRank = game.users[0].rank
      }
      if (opponent !== "Waiting for Opponent") {
        opponent = `vs ${opponent}`
      }
      
      if (this.state.currentUser) {
        profilePic = <ProfilePic key="ProfilePic" whichPic={this.state.currentUser.which_profile_pic} whichRank={this.state.currentUser.rank} where="GamePage" who="player"/>
      }
      
      return(
        <GameTile
          key={game.id}
          id={game.id}
          current_player={this.state.currentUser}
          opponent={opponent}
          opponentPic={opponentPic}
          opponentRank={opponentRank}
          clickable={true}
          whose_turn={game.whose_turn_id}
        />
      )
    })
    
    return(
      <div className="gamesContainerPage">
        <div className="gamesContainerNav">
          <div className = "gamesContainerNav-partone">
            {profilePic}
            <div className="gamesContainer-myGames">
              <ul className="gamesListButtons">
                  <li id="gamesListMyGames">My Games</li>
                  <a href="#" onClick={this.handleNewGame}><li id="gamesListCreate">Create Game</li></a>
                  <Link to='/matches'><li id="gamesListJoin">Join a Game</li></Link>
              </ul>
            </div>
          </div>
          {selectGameType}
        </div>
        {this.state.errorMessage}
        <div className="gameTileContainer">{games}</div>
      </div>
    )
  }
}

export default MyGamesContainer
