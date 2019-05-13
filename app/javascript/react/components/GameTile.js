import React from 'react';
import { Link } from 'react-router';

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
          {props.current_player.username}<img src={playerArrows}/>
          <img src={opponentArrows} />{props.opponent}
      </div>
    </Link>
  )
}

export default GameTile;
