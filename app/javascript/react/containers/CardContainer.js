import React from 'react'
import { Router, Route, IndexRoute, browserHistory } from 'react-router'

import CardTile from '../components/CardTile'

function generateEmptyRowOfCards() {
  let card = <CardTile which_card="/cardback.png" />
  let generate_layout = []
  let counter = 0
  while (counter < 48) {
    counter ++
      generate_layout = generate_layout.concat(<CardTile which_card="cardback" key={counter} /> )
  }
  return generate_layout
}

function generateRowOfCards(row, props) {
  let counter = 0
  let exportRow = []
  row.forEach((card) => {
    let isAdjacentCardSelected = false
    if (row.length > 1) {
      if (card.id === row[1].id && props.selected.includes(row[0].id)) {
        isAdjacentCardSelected = true
      }
      if (card.id === row[row.length - 2].id && props.selected.includes(row[row.length - 1].id)) {
        isAdjacentCardSelected = true
      }
    }
    
    let token = card.token
    if (((counter === 0 || counter === row.length - 1) && props.checkTurn() === true) || (isAdjacentCardSelected === true && props.checkTurn() === true)) {
      let selectedClass = ""
      if (props.selected.includes(card.id)) {
        selectedClass = "card-selected"
      }
      let cardFunction
      if (props.gemMode === false) {
        cardFunction = props.handleSelectCard
        if (card.gem && card.gem.id !== props.currentUser.id) {
          cardFunction = props.handleGemmedCard
        }
      } else if (props.gemMode === true) {
        cardFunction = props.handleGemPlacement
      }
      exportRow.push(<CardTile
        key={card.id}
        id={card.id}
        which_card={card}
        handleSelectCard={cardFunction}
        selectedClass={selectedClass}
        token={token}
        type="card-in-game"
        gem={card.gem}
        currentUser={props.currentUser}
        />)
      } else {
        let cardFunction = props.cantSelectMiddleCard
        if (props.gemMode === true) {
          cardFunction = props.handleGemPlacement
        }
        exportRow.push(<CardTile key={card.id} id={card.id} which_card={card} handleSelectCard={cardFunction} token={token} type="card-in-game" gem={card.gem} currentUser={props.currentUser}/>)
      }
    counter++
    })
  return exportRow
}

export const CardContainer = (props) => {
  let renderCards = []
  let statusText = ""
  let row_one = []
  let row_two = []
  let row_three = []
  let row_four = []
  
  if (props.gameState === "pending") {
    statusText = "Waiting on Opponent"
    let empty_rows = generateEmptyRowOfCards();
    row_four = empty_rows.splice(36)
    row_three = empty_rows.splice(24)
    row_two = empty_rows.splice(12)
    row_one = empty_rows
  } else if (props.gameState === "play") {
    row_one = generateRowOfCards(props.cards.row_one, props)
    row_two = generateRowOfCards(props.cards.row_two, props)
    row_three = generateRowOfCards(props.cards.row_three, props)
    row_four = generateRowOfCards(props.cards.row_four, props)
  }
  
  return(
    <div className="gameplay-cardContainer">
      {row_one}<br/>
      {row_two}<br/>
      {row_three}<br/>
      {row_four}<br/>
    </div>
  )
}

export default CardContainer
