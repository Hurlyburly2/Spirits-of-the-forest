import React from 'react';
import { Link } from 'react-router';

const TokenTile = (props) => {
  let image_url
  if (props.type === "gameplay-token") {
    image_url = "/tokens/TokenBack.png"
  }
  
  return(
    <img src={image_url} className="card-token"/>
  )
}

export default TokenTile;
