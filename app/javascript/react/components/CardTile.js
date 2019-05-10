import React from 'react';
import { Link } from 'react-router';

import TokenTile from './TokenTile'
import GemTile from './GemTile'

const CardTile = (props) => {
  let display_card = ""
  if (props.which_card === "cardback") {
    display_card = "/cardback.png"
  } else {
    display_card = props.which_card.image_url
  }
  
  let cardClass = `card ${props.selectedClass}`
  let token
  if (props.type === "card-in-game" && props.token) {
    token = <TokenTile token={props.token} type="gameplay-token"/>
  }
  
  let gem
  if (props.gem) {
    let gemID = `cardGem${props.which_card.id}`
    gem = <GemTile key={gemID} id={gemID} location="on-playboard" currentUser={props.currentUser} gem={props.gem} />
  }
  
  return(
    <div className={cardClass} onClick={props.handleSelectCard}>
      {token}
      {gem}
      <img src={display_card} id={props.id} />
    </div>
  )
}

export default CardTile;
