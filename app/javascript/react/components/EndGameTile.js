import React from 'react';
import { Link } from 'react-router';

const EndGameTile = (props) => {
  userBranchCards = props.yourCards.filter(card => card.spirit === "branch")
  userBranchCardTiles = userBranchCards.map((card) => {
    
  })
  
  return(
    <div className="score-grid-wrapper">
      <div className="score-grid">
        <div className="score-player-one-name">{props.currentUser.username}</div>
        <div className="score-player-two-name">{props.opponent.username}</div>
        
        <div className="score-icon-branch">branch</div>
        <div className="score-icon-dew">dew</div>
        <div className="score-icon-flower">flower</div>
        <div className="score-icon-fruit">fruit</div>
        <div className="score-icon-leaf">leaf</div>
        <div className="score-icon-moss">moss</div>
        <div className="score-icon-mushroom">mushroom</div>
        <div className="score-icon-spider">spider</div>
        <div className="score-icon-vine">vine</div>
        <div className="score-icon-sun">sun</div>
        <div className="score-icon-moon">moon</div>
        <div className="score-icon-wind">wind</div>
        <div className="score-icon-total">total</div>
      </div>
    </div>
  )
}

export default EndGameTile;
