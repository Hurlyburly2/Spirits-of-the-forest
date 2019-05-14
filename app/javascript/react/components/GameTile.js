import React from 'react';
import { Link } from 'react-router';

import ProfilePic from './ProfilePic'

const GameTile = (props) => {
  let url = ""
  if (props.clickable == true) {
    url = `/games/${props.id}`
  } else {
    url = ''
  }
  
  let playerArrows=""
  let opponentArrows=""
  if (props.whose_turn === props.current_player.id) {
    playerArrows = "/misc/smallarrow-left.png"
  } else if (props.opponent !== "Waiting for Opponent") {
    opponentArrows = "/misc/smallarrow-right.png"
  }
  
  return(
    <Link to={url}>
      <div className="gameTile">
        <ProfilePic key={`${props.id}pic1`} whichPic={props.current_player.which_profile_pic} whichRank={props.current_player.rank} where="GameTile" who="player"/>
        
        <div className = "gameTile-textbox">
          <div className = "gameTile-playerName">
            {props.current_player.username}<img src={playerArrows} className="gameTile-arrow gameTile-arrow-player"/><img src={playerArrows} className="gameTile-arrow"/>
          </div>
          <hr id="gameTile-divider"/>
          <div className = "gameTile-opponentName">
            <img src={opponentArrows} className="gameTile-arrow"/><img src={opponentArrows} className="gameTile-arrow gameTile-arrow-opponent"/><span>{props.opponent}</span>
          </div>
        </div>
        
        <ProfilePic key={`${props.id}pic2`} whichPic={props.opponentPic} whichRank={props.opponentRank} where="GameTile" who="opponent"/>
      </div>
    </Link>
  )
}

export default GameTile;
