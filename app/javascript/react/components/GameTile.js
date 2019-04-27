import React from 'react';
import { Link } from 'react-router';

const GameTile = (props) => {
  let url = `/games/${props.id}`
  return(
    <Link to={url}><div className="gameTile">
        <span>Game #{props.id}<br />
        {props.opponent}</span>
    </div></Link>
  )
}

export default GameTile;
