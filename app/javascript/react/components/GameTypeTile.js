import React from 'react';
import { Link } from 'react-router';

const GameTypeTile = (props) => {
  return (
    <div className = "gameTypeBox">
      <h1>Select a Type of Game: </h1>
      
      <div className = "gameSelectionCenter">
        <div className = "gameSelectionZone">
          <img src = "/tiny-icons/DewIcon-small.png" className = "onePlayerIcon" />
          <img src = "/tiny-icons/BranchIcon-small.png" className = "twoPlayerIconOne" />
          <img src = "/tiny-icons/FlowerIcon-small.png" className = "twoPlayerIconTwo" />
        </div> 
      </div>
      
    </div>
  )
}

export default GameTypeTile;
