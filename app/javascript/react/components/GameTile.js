import React from 'react';
import { Link } from 'react-router';

const GameTile = (props) => {
  let url = ""
  if (props.clickable == true) {
    url = `/games/${props.id}`
  } else {
    url = ''
  }
  
  
  return(
    <Link to={url}><div className="gameTile">
        <span>Game #{props.id}<br />
        {props.opponent}</span>
    </div></Link>
  )
}

export default GameTile;
