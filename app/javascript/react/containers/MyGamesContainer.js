import React, { Component }  from 'react';

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
      debugger
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
    debugger
    return(
      <div className="gamesContainerPage">
        <h1>MY GAMES</h1>
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
