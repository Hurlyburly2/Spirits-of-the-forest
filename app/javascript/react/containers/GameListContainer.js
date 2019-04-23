import React, { Component } from 'react'

class GameListContainer extends Component {
  constructor(props) {
    super(props)
    this.state = {
      
    }
  }
  
  render() {
    return(
      <div>
        <h1>MY GAMES</h1>
        <ul>
          <li>GAME1</li>
          <li>GAME2</li>
          <li>GAME3</li>
        </ul>
      </div>
    )
  }
}

export default GameListContainer
