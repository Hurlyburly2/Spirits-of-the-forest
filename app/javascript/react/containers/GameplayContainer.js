import React, { Component }  from 'react';
import { Link } from 'react-router'

import CardTile from '../components/CardTile.js'
import CardContainer from './CardContainer'

class GameplayContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      gameState: null,
      currentUser: null,
      opponent: null,
      whose_turn: null,
      selected: [],
      selectedSpiritPoints: 0,
      cards: {
        row_one: [],
        row_two: [],
        row_three: [],
        row_four: []
      },
      cardReference: [],
      errorMessage: []
    }
    this.selectCard = this.selectCard.bind(this);
    this.checkTurn = this.checkTurn.bind(this);
    this.confirmCardSelection = this.confirmCardSelection.bind(this)
  }
  
  componentDidMount() {
    let refreshInterval = 100000 //This should be 5000 in release version
    this.refreshInterval = setInterval(() => this.getGameData(), refreshInterval);
    this.getGameData();
  }
  
  getGameData() {
    let current_game = this.props.params.id
    let backgroundDiv = document.getElementById('overlay') 
    backgroundDiv.classList.add('overlay')
    fetch(`/api/v1/games/${current_game}`)
      .then(response => {
      if (response.ok) {
        return response
      } else {
        let errorMessage = `${response.status} (${response.statusText})`,
          error = new Error(errorMessage)
        throw(error)
      }
    })
    .then(response => response.json())
    .then(body => {
      this.setState({
        gameState: body.gameState,
        currentUser: body.currentUser,
        opponent: body.opponent,
        cards: JSON.parse(body.cards),
        whose_turn: body.whose_turn,
        cardReference: body.card_reference
      })
    })
  }
  
  confirmCardSelection() {
    if (this.state.selected.length > 0) {
      let current_game = this.props.params.id
      let gamePayLoad = {
        selected: this.state.selected,
        currentUser: this.state.currentUser
      }
      fetch(`/api/v1/games/${current_game}`, {
        credentials: 'same-origin',
        method: "PATCH",
        body: JSON.stringify(gamePayLoad),
        headers: {
          Accept: "application/json",
          "Content-Type": "application/json"
        }
      })
      .then(response => {
        if (response.ok) {
          return response
        } else {
          let errorMessage = `${response.status} (${response.statusText})`,
          error = new Error(errorMessage)
          throw error
        }
      })
      .then(response => response.json())
      .then(body => {
        this.setState({
          gameState: body.gameState,
          currentUser: body.currentUser,
          opponent: body.opponent,
          cards: JSON.parse(body.cards),
          whose_turn: body.whose_turn,
          cardReference: body.card_reference,
          selected: [],
          selectedSpiritPoints: 0,
          errorMessage: body.errorMessage
        })
      })
    } else {
      this.setState({
        errorMessage: "You have not selected any cards!"
      })
    }
  }

  
  componentWillUnmount() {
    clearInterval(this.refreshInterval);
    let backgroundDiv = document.getElementById('overlay') 
    backgroundDiv.classList.remove('overlay')
  }
  
  deleteGame () {
    let game_id = this.props.params.id
    let gamestateToSend
    if (this.state.gameState === "pending") {
      gamestateToSend = "deleteWithoutLoss"
    } else if (this.state.gameState === "play") {
      gamestateToSend = "concession"
    }
    let endGamePayload = {
      game_id: game_id,
      gameState: gamestateToSend,
      user: this.state.currentUser
    }
    fetch(`/api/v1/games/${game_id}`, {
      credentials: 'same-origin',
      method: 'DELETE',
      body: JSON.stringify(endGamePayload),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      }
    })
    .then(response => {
        if (response.ok) {
          return response;
        } else {
          let errorMessage = `${response.status} (${response.statusText})`,
              error = new Error(errorMessage);
          throw(error);
        }
      })
      .then(response => response.json())
      .then(body => {
        return window.location.href = "/"
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`));
  }
  
  selectCard(event) {
    let clickedCard = parseInt(event.target.id)
    let cardStats = this.state.cardReference.find( card => card.id === clickedCard)
    if (this.state.selected.includes(clickedCard)) {
      let removeCardIndex = this.state.selected.indexOf(clickedCard)
      let newArray = this.state.selected
      let newScore = this.state.selectedSpiritPoints - cardStats.spirit_points
      newArray.splice(removeCardIndex, 1)
      
      let deSelectPartner = this.state.cards.row_one[1].id
      if (this.state.cards.row_one[0].id === clickedCard && newArray.includes(deSelectPartner)) {
        let partnerStats = this.state.cardReference.find( card => card.id === deSelectPartner )
        newScore = newScore - partnerStats.spirit_points
        let removeCardIndex = newArray.indexOf(deSelectPartner)
        newArray.splice(removeCardIndex, 1)
      }
      deSelectPartner = this.state.cards.row_one[this.state.cards.row_one.length - 2].id
      if (this.state.cards.row_one[this.state.cards.row_one.length - 1].id === clickedCard && newArray.includes(deSelectPartner)) {
        let partnerStats = this.state.cardReference.find( card => card.id === deSelectPartner )
        newScore = newScore - partnerStats.spirit_points
        let removeCardIndex = newArray.indexOf(deSelectPartner)
        newArray.splice(removeCardIndex, 1)
      }
      deSelectPartner = this.state.cards.row_two[1].id
      if (this.state.cards.row_two[0].id === clickedCard && newArray.includes(deSelectPartner)) {
        let partnerStats = this.state.cardReference.find( card => card.id === deSelectPartner )
        newScore = newScore - partnerStats.spirit_points
        let removeCardIndex = newArray.indexOf(deSelectPartner)
        newArray.splice(removeCardIndex, 1)
      }
      deSelectPartner = this.state.cards.row_two[this.state.cards.row_two.length - 2].id
      if (this.state.cards.row_two[this.state.cards.row_two.length - 1].id === clickedCard && newArray.includes(deSelectPartner)) {
        let partnerStats = this.state.cardReference.find( card => card.id === deSelectPartner )
        newScore = newScore - partnerStats.spirit_points
        let removeCardIndex = newArray.indexOf(deSelectPartner)
        newArray.splice(removeCardIndex, 1)
      }
      deSelectPartner = this.state.cards.row_three[1].id
      if (this.state.cards.row_three[0].id === clickedCard && newArray.includes(deSelectPartner)) {
        let partnerStats = this.state.cardReference.find( card => card.id === deSelectPartner )
        newScore = newScore - partnerStats.spirit_points
        let removeCardIndex = newArray.indexOf(deSelectPartner)
        newArray.splice(removeCardIndex, 1)
      }
      deSelectPartner = this.state.cards.row_three[this.state.cards.row_three.length - 2].id
      if (this.state.cards.row_three[this.state.cards.row_three.length - 1].id === clickedCard && newArray.includes(deSelectPartner)) {
        let partnerStats = this.state.cardReference.find( card => card.id === deSelectPartner )
        newScore = newScore - partnerStats.spirit_points
        let removeCardIndex = newArray.indexOf(deSelectPartner)
        newArray.splice(removeCardIndex, 1)
      }
      deSelectPartner = this.state.cards.row_four[1].id
      if (this.state.cards.row_four[0].id === clickedCard && newArray.includes(deSelectPartner)) {
        let partnerStats = this.state.cardReference.find( card => card.id === deSelectPartner )
        newScore = newScore - partnerStats.spirit_points
        let removeCardIndex = newArray.indexOf(deSelectPartner)
        newArray.splice(removeCardIndex, 1)
      }
      deSelectPartner = this.state.cards.row_four[this.state.cards.row_four.length - 2].id
      if (this.state.cards.row_four[this.state.cards.row_four.length - 1].id === clickedCard && newArray.includes(deSelectPartner)) {
        let partnerStats = this.state.cardReference.find( card => card.id === deSelectPartner )
        newScore = newScore - partnerStats.spirit_points
        let removeCardIndex = newArray.indexOf(deSelectPartner)
        newArray.splice(removeCardIndex, 1)
      }
      
      this.setState({
        selected: newArray,
        selectedSpiritPoints: newScore,
        errorMessage: ""
      })
    } else {
      if (this.state.selectedSpiritPoints + cardStats.spirit_points > 2) {
        this.setState({
          errorMessage: "You cannot take more than two spirits!"
        })
      } else if (this.state.selectedSpiritPoints > 0 && this.state.cardReference.find( card => card.id === clickedCard ).spirit !== this.state.cardReference.find(card => card.id === this.state.selected[0] ).spirit) {
        this.setState({
          errorMessage: "You cannot select more than one type of spirit!"
        })
      } else {
        let newScore = this.state.selectedSpiritPoints + cardStats.spirit_points
        this.setState({
          selected: this.state.selected.concat(clickedCard),
          selectedSpiritPoints: newScore,
          errorMessage: ""
        })
      }
    }
  }
  
  checkTurn() {
    if (this.state.currentUser.id === this.state.whose_turn.id) {
      return true
    } else {
      return false
    }
  }
  
  render() {
    let statusText
    let currentPlayerName = ""
    let opponentName = ""
    let whose_turn = ""
    let message = ""
    let endGame = ""
    let handleDeleteGame = () => { this.deleteGame() }
    let handleConfirmCardSelection = () => { this.confirmCardSelection() }
    let confirmButton = null
    
    if (this.state.gameState === "play"){
      if (this.state.currentUser && this.state.opponent) {  
        currentPlayerName = this.state.currentUser.username
        opponentName = this.state.opponent.username
        if (this.state.whose_turn.id === this.state.currentUser.id) {
          message = "Your Turn"
          confirmButton = <li onClick={handleConfirmCardSelection}>CONFIRM SELECTION</li>
        } else {
          message = `${this.state.whose_turn.username}'s Turn`
        }
      }
      endGame = "CONCEDE"
    } else if (this.state.gameState === "error") {
      message = "This game is no longer available"
    } else if (this.state.gameState === "pending") {
      message = "Waiting for Opponent..."
      endGame = "DELETE GAME"
    }
    
    return(
      <div className="gamesContainerPage">
        <h4>{currentPlayerName} {message} {opponentName}</h4>
        <CardContainer 
          gameState={this.state.gameState}
          cards={this.state.cards}
          handleSelectCard={this.selectCard}
          checkTurn={this.checkTurn}
          selected={this.state.selected}
        />
        <p className="errorText">{this.state.errorMessage}</p>
        <ul className="gamePlayButtons">
          <Link to='/'><li>MY GAMES</li></Link>
          {confirmButton}
          <li onClick={handleDeleteGame}>{endGame}</li>
        </ul>
      </div>
    )
  }
}

export default GameplayContainer
