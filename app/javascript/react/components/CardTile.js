import React from 'react';
import { Link } from 'react-router';

const CardTile = (props) => {
  let display_card = ""
  if (props.which_card === "cardback") {
    display_card = "/cardback.png"
  } else {
    display_card = props.which_card.image_url
  }
  
  let cardClass = `card ${props.selectedClass}`
  
  return(
    <img src={display_card} className={cardClass} onClick={props.handleSelectCard} id={props.id} />
  )
}

export default CardTile;
