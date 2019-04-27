import React from 'react';
import { Link } from 'react-router';

const GameTile = (props) => {
  return(
    <div className="gameTile" onClick={props.handleClickTile}>
        <span>Game #{props.id}<br />
        {props.opponent}</span>
    </div>
  )
}

export default GameTile;
