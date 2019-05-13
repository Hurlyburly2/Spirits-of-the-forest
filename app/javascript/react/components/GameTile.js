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
        <ProfilePic key={`${props.id}pic1`} whichPic={props.current_player.which_profile_pic} whichRank={props.current_player.rank} where="GameTile"/>
        {props.current_player.username}<img src={playerArrows}/>
        <img src={opponentArrows} /><span>{props.opponent}</span>
        <ProfilePic key={`${props.id}pic2`} whichPic={props.opponentPic} whichRank={props.opponentRank} where="GameTile"/>
      </div>
    </Link>
  )
}

export default GameTile;
