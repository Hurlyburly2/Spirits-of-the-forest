import React from 'react';
import { Link } from 'react-router';

const GameTile = (props) => {
  return(
    <div className="gameTile">
      <a href="#" className="gameTileLink">{props.opponent}</a>
    </div>
  )
}

export default GameTile;
