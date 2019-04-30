import React from 'react'
import { Router, Route, IndexRoute, browserHistory } from 'react-router'

import CardTile from '../components/CardTile'

export const CardContainer = (props) => {
  let renderCards = []
  let statusText = ""
  if (props.gameState === "pending") {
    debugger
    statusText = "Waiting on Opponent"
    renderCards = <CardTile which_card="cardback" />
  }
  
  return(
    <div>
      {renderCards}
    </div>
  )
}

export default CardContainer
