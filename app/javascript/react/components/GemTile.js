import React from 'react';
import { Link } from 'react-router';

const GemTile = (props) => {
  let imageURL
  let whatClass
  
  if (props.player === "user") {
    imageURL = "/gems/BlueGem.png"
  } else if (props.player === "opponent") {
    imageURL = "/gems/RedGem.png"
  }
  
  if (props.location === "in-hand") {
    whatClass = "gems-in-hand"
  }
  
  return(
    <img src={imageURL} className={whatClass} />
  )
}

export default GemTile;

//props: location, player
