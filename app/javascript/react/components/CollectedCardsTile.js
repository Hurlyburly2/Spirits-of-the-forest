import React from 'react';
import { Link } from 'react-router';

import CardTile from './CardTile'
import TokenTile from './TokenTile'

const CollectedCardsTile = (props) => {
  let whoseClassName
  if (props.whose === "player") {
    whoseClassName = "collected-cards-tile-wrapper player"
  } else if (props.whose === "opponent") {
    whoseClassName = "collected-cards-tile-wrapper opponent-collected"
  }
  
  let branchCards = props.cards.filter(card => card.spirit === "branch")
  let dewCards = props.cards.filter(card => card.spirit === "dew")
  let flowerCards = props.cards.filter(card => card.spirit === "flower")
  let fruitCards = props.cards.filter(card => card.spirit === "fruit")
  let leafCards = props.cards.filter(card => card.spirit === "leaf")
  let mossCards = props.cards.filter(card => card.spirit === "moss")
  let mushroomCards = props.cards.filter(card => card.spirit === "mushroom")
  let spiderCards = props.cards.filter(card => card.spirit === "spider")
  let vineCards = props.cards.filter(card => card.spirit === "vine")
  
  let branchCardTiles = branchCards.map((card) => {
    return(
      <CardTile
        key={card.id}
        id={card.id}
        which_card={card}
        handleSelectCard=""
        selectedClass="collected-card"
      />
    )
  })
  let dewCardTiles = dewCards.map((card) => {
    return(
      <CardTile
        key={card.id}
        id={card.id}
        which_card={card}
        handleSelectCard=""
        selectedClass="collected-card"
      />
    )
  })
  let flowerCardTiles = flowerCards.map((card) => {
    return(
      <CardTile
        key={card.id}
        id={card.id}
        which_card={card}
        handleSelectCard=""
        selectedClass="collected-card"
      />
    )
  })
  let fruitCardTiles = fruitCards.map((card) => {
    return(
      <CardTile
        key={card.id}
        id={card.id}
        which_card={card}
        handleSelectCard=""
        selectedClass="collected-card"
      />
    )
  })
  let leafCardTiles = leafCards.map((card) => {
    return(
      <CardTile
        key={card.id}
        id={card.id}
        which_card={card}
        handleSelectCard=""
        selectedClass="collected-card"
      />
    )
  })
  let mossCardTiles = mossCards.map((card) => {
    return(
      <CardTile
        key={card.id}
        id={card.id}
        which_card={card}
        handleSelectCard=""
        selectedClass="collected-card"
      />
    )
  })
  let mushroomCardTiles = mushroomCards.map((card) => {
    return(
      <CardTile
        key={card.id}
        id={card.id}
        which_card={card}
        handleSelectCard=""
        selectedClass="collected-card"
      />
    )
  })
  let spiderCardTiles = spiderCards.map((card) => {
    return(
      <CardTile
        key={card.id}
        id={card.id}
        which_card={card}
        handleSelectCard=""
        selectedClass="collected-card"
      />
    )
  })
  let vineCardTiles = vineCards.map((card) => {
    return(
      <CardTile
        key={card.id}
        id={card.id}
        which_card={card}
        handleSelectCard=""
        selectedClass="collected-card"
      />
    )
  })
  
  let collectedTokens = props.tokens.map((token) => {
    return(<TokenTile token={token} type="CollectedCardsDisplay" whose={props.whose}/>)
  })
  
  
  return(
    <div className ={whoseClassName} onClick={props.toggleAppearance}>
      <h1>{props.name}'s Cards:</h1>
      {branchCardTiles}
      {dewCardTiles}
      {flowerCardTiles}
      {fruitCardTiles}
      {leafCardTiles}
      {mossCardTiles}
      {mushroomCardTiles}
      {spiderCardTiles}
      {vineCardTiles}
      {collectedTokens}
    </div>
  )
}

export default CollectedCardsTile;
