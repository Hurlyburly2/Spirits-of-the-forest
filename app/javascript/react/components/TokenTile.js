import React from 'react';
import { Link } from 'react-router';

const TokenTile = (props) => {
  let imageURL
  let tokenClass
  if (props.type === "gameplay-token") {
    imageURL = "/tokens/TokenBack.png"
    tokenClass = "card-token"
  } else if (props.type === "CollectedCardsDisplay" && props.whose === "player") {
    imageURL = props.token.image_url
    tokenClass = "collectedCards-Token"
  } else if (props.type === "CollectedCardsDisplay" && props.whose === "opponent") {
    imageURL = "/tokens/TokenBack.png"
    tokenClass = "collectedCards-Token"
  } else if (props.type === "endGameDisplay") {
    imageURL = props.token.image_url
    tokenClass = "endGameDisplay-Token"
  }
  
  return(
    <img src={imageURL} className={tokenClass} />
  )
}

export default TokenTile;
