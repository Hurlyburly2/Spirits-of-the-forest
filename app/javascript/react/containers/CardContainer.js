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
  //props.GemMode
  
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
    let counter = 0
    let row_length = props.cards.row_one.length
    props.cards.row_one.forEach((card) => {
      let isAdjacentCardSelected = false
      if (props.cards.row_one.length > 1) {
        if (card.id === props.cards.row_one[1].id && props.selected.includes(props.cards.row_one[0].id)) {
          isAdjacentCardSelected = true
        }
        if (card.id === props.cards.row_one[props.cards.row_one.length - 2].id && props.selected.includes(props.cards.row_one[props.cards.row_one.length - 1].id)) {
          isAdjacentCardSelected = true
        }
      }
      
      let token = card.token
      if (((counter === 0 || counter === row_length - 1) && props.checkTurn() === true) || (isAdjacentCardSelected === true && props.checkTurn() === true)) {
        let selectedClass = ""
        if (props.selected.includes(card.id)) {
          selectedClass = "card-selected"
        }
        let cardFunction
        if (props.gemMode === false) {
          cardFunction = props.handleSelectCard
        } else if (props.gemMode === true) {
          cardFunction = props.handleGemPlacement
        }
        row_one.push(<CardTile
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
          let cardFunction = ""
          if (props.gemMode === true) {
            cardFunction = props.handleGemPlacement
          }
          row_one.push(<CardTile key={card.id} id={card.id} which_card={card} handleSelectCard={cardFunction} token={token} type="card-in-game" gem={card.gem} currentUser={props.currentUser}/>)
        }
      counter++
    })
    
    counter = 0
    row_length = props.cards.row_two.length
    props.cards.row_two.forEach((card) => {
      let isAdjacentCardSelected = false
      
      if (props.cards.row_two.length > 1) {
        if (card.id === props.cards.row_two[1].id && props.selected.includes(props.cards.row_two[0].id)) {
          isAdjacentCardSelected = true
        }
        if (card.id === props.cards.row_two[props.cards.row_two.length - 2].id && props.selected.includes(props.cards.row_two[props.cards.row_two.length - 1].id)) {
          isAdjacentCardSelected = true
        }
      }
      
      let token = card.token
      if (((counter === 0 || counter === row_length - 1) && props.checkTurn() === true) || (isAdjacentCardSelected === true && props.checkTurn() === true)) {
        let selectedClass = ""
        if (props.selected.includes(card.id)) {
          selectedClass = "card-selected"
        }
        let cardFunction
        if (props.gemMode === false) {
          cardFunction = props.handleSelectCard
        } else if (props.gemMode === true) {
          cardFunction = props.handleGemPlacement
        }
        row_two.push(<CardTile
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
        let cardFunction = ""
        if (props.gemMode === true) {
          cardFunction = props.handleGemPlacement
        }
        row_two.push(<CardTile key={card.id} id={card.id} which_card={card} handleSelectCard={cardFunction} token={token} type="card-in-game" gem={card.gem}
        currentUser={props.currentUser}/>)
      }
      counter++
    })
    
    counter = 0
    row_length = props.cards.row_three.length
    props.cards.row_three.forEach((card) => {
      let isAdjacentCardSelected = false
      if (props.cards.row_three.length > 1) {
        if (card.id === props.cards.row_three[1].id && props.selected.includes(props.cards.row_three[0].id)) {
          isAdjacentCardSelected = true
        }
        if (card.id === props.cards.row_three[props.cards.row_three.length - 2].id && props.selected.includes(props.cards.row_three[props.cards.row_three.length - 1].id)) {
          isAdjacentCardSelected = true
        }
      }
      
      let token = card.token
      if (((counter === 0 || counter === row_length - 1) && props.checkTurn() === true) || (isAdjacentCardSelected === true && props.checkTurn() === true)) {
        let selectedClass = ""
        if (props.selected.includes(card.id)) {
          selectedClass = "card-selected"
        }
        let cardFunction
        if (props.gemMode === false) {
          cardFunction = props.handleSelectCard
        } else if (props.gemMode === true) {
          cardFunction = props.handleGemPlacement
        }
        row_three.push(<CardTile
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
        let cardFunction = ""
        if (props.gemMode === true) {
          cardFunction = props.handleGemPlacement
        }
        row_three.push(<CardTile key={card.id} id={card.id} which_card={card} handleSelectCard={cardFunction} token={token} type="card-in-game" gem={card.gem}
        currentUser={props.currentUser}/>)
      }
      counter++
    })
    
    counter = 0
    row_length = props.cards.row_four.length
    props.cards.row_four.forEach((card) => {
      let isAdjacentCardSelected = false
      if (props.cards.row_four.length > 1) {
        if (card.id === props.cards.row_four[1].id && props.selected.includes(props.cards.row_four[0].id)) {
          isAdjacentCardSelected = true
        }
        if (card.id === props.cards.row_four[props.cards.row_four.length - 2].id && props.selected.includes(props.cards.row_four[props.cards.row_four.length - 1].id)) {
          isAdjacentCardSelected = true
        }
      }
      
      let token = card.token
      if (((counter === 0 || counter === row_length - 1) && props.checkTurn() === true) || (isAdjacentCardSelected === true && props.checkTurn() === true)) {
        let selectedClass = ""
        if (props.selected.includes(card.id)) {
          selectedClass = "card-selected"
        }
        let cardFunction
        if (props.gemMode === false) {
          cardFunction = props.handleSelectCard
        } else if (props.gemMode === true) {
          cardFunction = props.handleGemPlacement
        }
        row_four.push(<CardTile
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
        let cardFunction = ""
        if (props.gemMode === true) {
          cardFunction = props.handleGemPlacement
        }
        row_four.push(<CardTile key={card.id} id={card.id} which_card={card} handleSelectCard={cardFunction} token={token} type="card-in-game" gem={card.gem}
        currentUser={props.currentUser}/>)
      }
      counter++
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
