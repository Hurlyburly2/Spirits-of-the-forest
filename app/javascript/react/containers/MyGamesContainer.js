import React, { Component }  from 'react';
import { Link } from 'react-router'

import GameTile from '../components/GameTile'

class MyGamesContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      myGames: [],
      currentUser: null,
      errorMessage: ""
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
      debugger
      this.setState({
        myGames: body.games,
        currentUser: body.current_user
      })
    })
  }
  
  createNewGame() {
    let newGamePayload = this.state.currentUser
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
          myGames: this.state.myGames.concat(body.games)
        })
      })
  }
  
  handleNewGame() {
    if (this.state.myGames.length < 18) {
      this.createNewGame()
    } else {
      this.setState({
        errorMessage: "You cannot have more than 18 games! Please finish games or concede to create more"
      })
    }
  }
  
  handleClickTile(event) {
    debugger
  }
  
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
        opponent = `vs ${opponent}`
      }
      
      
      return(
        <GameTile
          key={game.id}
          id={game.id}
          current_player={this.currentUser}
          opponent={opponent}
          clickable={true}
        />
      )
    })
    
    return(
      <div className="gamesContainerPage">
        <h1>MY GAMES</h1>
        {this.state.errorMessage}
        <div className="gameTileContainer">{games}</div>
        <ul className="gamesListButtons">
          <a href="#" onClick={this.handleNewGame}><li>CREATE GAME</li></a>
          <Link to='/matches'><li>JOIN A GAME</li></Link>
        </ul>
      </div>
    )
  }
}

export default MyGamesContainer
