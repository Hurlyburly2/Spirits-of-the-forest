import React, { Component }  from 'react';

class MyGamesContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
    }
  }
  
  render() {
    return(
      <div className="gamesContainerPage">
        <h1>MY GAMES</h1>
        <ul className="gamesListButtons">
          <a href="#"><li>NEW</li></a>
          <a href="#"><li>JOIN</li></a>
          <a href="#"><li>DELETE</li></a>
        </ul>
      </div>
    )
  }
}

export default MyGamesContainer
