import React from 'react'
import { Router, Route, IndexRoute, browserHistory } from 'react-router'

import CardTile from '../components/CardTile'

export const CardContainer = (props) => {
  let renderCards = []
  let statusText = ""
  let row_one = []
  let row_two = []
  let row_three = []
  let row_four = []
  
  if (props.gameState === "pending") {
    statusText = "Waiting on Opponent"
    let card = <CardTile which_card="/cardback.png" />
    let generate_layout = []
    let counter = 0
    while (counter < 48) {
      counter ++
        generate_layout = generate_layout.concat(<CardTile which_card="cardback" key={counter} /> )
    }
    row_four = generate_layout.splice(36)
    row_three = generate_layout.splice(24)
    row_two = generate_layout.splice(12)
    row_one = generate_layout
  } else if (props.gameState === "play") {
    props.cards.row_one.forEach((card) => {
      row_one.push(<CardTile key={card.id} id={card.id} which_card={card} />)
    })
    props.cards.row_two.forEach((card) => {
      row_two.push(<CardTile key={card.id} id={card.id} which_card={card} />)
    })
    props.cards.row_three.forEach((card) => {
      row_three.push(<CardTile key={card.id} id={card.id} which_card={card} />)
    })
    props.cards.row_four.forEach((card) => {
      row_four.push(<CardTile key={card.id} id={card.id} which_card={card} />)
    })
  }
  
  return(
    <div>
      {row_one}<br/>
      {row_two}<br/>
      {row_three}<br/>
      {row_four}<br/>
    </div>
  )
}

export default CardContainer
