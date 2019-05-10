import React from 'react';
import { Link } from 'react-router';

const GemTile = (props) => {
  let imageURL
  let whatClass
  
  
  
  if (props.location === "in-hand") {
    whatClass = "gems-in-hand"
    if (props.player === "user") {
      imageURL = "/gems/BlueGem.png"
    } else if (props.player === "opponent") {
      imageURL = "/gems/RedGem.png"
    }
  } else if (props.location === "on-playboard") {
    whatClass = "card-gem"
    if (props.gem.id === props.currentUser.id) {
      imageURL = "/gems/BlueGem.png"
    } else {
      imageURL = "/gems/RedGem.png"
    }
  }
  
  return(
    <img src={imageURL} className={whatClass} />
  )
}

export default GemTile;

//props: location, player
