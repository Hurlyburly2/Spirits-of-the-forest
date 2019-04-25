import React from 'react';
import { Link } from 'react-router';

const GameTile = (props) => {
  return(
    <div className="gameTile">
      <a href="#" className="gameTileLink">
        Game #{props.id}<br />
        {props.opponent}
      </a>
    </div>
  )
}

export default GameTile;
