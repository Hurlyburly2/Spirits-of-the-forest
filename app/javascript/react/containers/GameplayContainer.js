import React, { Component }  from 'react';
import { Link } from 'react-router'

import CardTile from '../components/CardTile.js'
import CardContainer from './CardContainer'
import CollectedCardsTile from '../components/CollectedCardsTile'
import EndGameTile from '../components/EndGameTile'

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
      errorMessage: [],
      winner: null,
      yourCards: [],
      opponentCards: [],
      showCollectedTile: false,
      score: null
    }
    this.selectCard = this.selectCard.bind(this);
    this.checkTurn = this.checkTurn.bind(this);
    this.confirmCardSelection = this.confirmCardSelection.bind(this)
    this.togglePlayerCollectedTile = this.togglePlayerCollectedTile.bind(this)
    this.toggleOpponentCollectedTile = this.toggleOpponentCollectedTile.bind(this)
  }
  
  componentDidMount() {
    let refreshInterval = 2000 //This should be 5000 in release version
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
      let opponentCardJSON = JSON.parse(body.opponentcards)
      if (opponentCardJSON === "none") {
        opponentCardJSON = []
      }
      debugger
      this.setState({
        gameState: body.gameState,
        currentUser: body.currentUser,
        opponent: body.opponent,
        cards: JSON.parse(body.cards),
        whose_turn: body.whose_turn,
        cardReference: body.card_reference,
        winner: body.winner,
        yourCards: JSON.parse(body.yourcards),
        opponentCards: opponentCardJSON,
        score: JSON.parse(body.score)
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
          yourCards: JSON.parse(body.yourcards),
          opponentCards: JSON.parse(body.opponentcards),
          errorMessage: body.errorMessage,
          score: JSON.parse(body.score)
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
    } else if (this.state.gameState === "complete") {
      gamestateToSend = "confirmGameOver"
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
        if (body.gameState === "done") {
          this.setState({
            gameState: "complete"
          })
        } else if (body.gameState === "endGameConfirmed") {
          return window.location.href = "/"
        }
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
  
  togglePlayerCollectedTile(event) {
    if (this.state.showCollectedTile === false) {
      this.setState({
        showCollectedTile: "player"
      })
    } else {
      this.setState({
        showCollectedTile: false
      })
    }
  }
  
  toggleOpponentCollectedTile(event) {
    if (this.state.showCollectedTile === false) {
      this.setState({
        showCollectedTile: "opponent"
      })
    } else {
      this.setState({
        showCollectedTile: false
      })
    }
  }
  
  render() {
    let statusText
    let currentPlayerName = ""
    let showCollectedCards
    let opponentName = ""
    let whose_turn = ""
    let message = ""
    let endGame = ""
    let handleDeleteGame = () => { this.deleteGame() }
    let handleConfirmCardSelection = () => { this.confirmCardSelection() }
    let confirmButton = null
    let completeScreen
    let deleteButton
    let backButton = <Link to='/'><li>MY GAMES</li></Link>
    let errorMessage
    
    if (this.state.gameState === "play"){
      if (this.state.currentUser && this.state.opponent) {  
        
        currentPlayerName = <span onClick={this.togglePlayerCollectedTile}>{this.state.currentUser.username}</span>
        opponentName = <span onClick={this.toggleOpponentCollectedTile}>{this.state.opponent.username}</span>
        if (this.state.showCollectedTile === "player") {
          showCollectedCards = <CollectedCardsTile 
            whose="player"
            toggleAppearance={this.togglePlayerCollectedTile}
            name={this.state.currentUser.username}
            cards={this.state.yourCards}
          />
        } else if (this.state.showCollectedTile === "opponent") {
          showCollectedCards = <CollectedCardsTile
            whose="opponent"
            toggleAppearance={this.toggleOpponentCollectedTile}
            name={this.state.opponent.username}
            cards={this.state.opponentCards}
          />
        }
        
        if (this.state.whose_turn.id === this.state.currentUser.id) {
          message = "Your Turn"
          confirmButton = <li onClick={handleConfirmCardSelection}>CONFIRM SELECTION</li>
        } else {
          message = `${this.state.whose_turn.username}'s Turn`
        }
      }
      deleteButton = <li onClick={handleDeleteGame}>CONCEDE</li>
      endGame = "CONCEDE"
      errorMessage = this.state.errorMessage
    } else if (this.state.gameState === "error") {
      message = "This game is no longer available"
      errorMessage = this.state.errorMessage
    } else if (this.state.gameState === "pending") {
      message = "Waiting for Opponent..."
      deleteButton = <li onClick={handleDeleteGame}>DELETE GAME</li>
      errorMessage = this.state.errorMessage
    } else if (this.state.gameState === "complete") {
      backButton = <li onClick={handleDeleteGame}>OK</li>
      completeScreen = <EndGameTile 
                          yourCards={this.state.yourCards}
                          opponentCards={this.state.opponentCards}
                          currentUser={this.state.currentUser}
                          opponent={this.state.opponent}
                          score={this.state.score}
                        />
    }
    
    return(
      <div className="gamesContainerPage">
        {showCollectedCards}
        <h4>{currentPlayerName} {message} {opponentName}</h4>
        {completeScreen}
        <CardContainer 
          gameState={this.state.gameState}
          cards={this.state.cards}
          handleSelectCard={this.selectCard}
          checkTurn={this.checkTurn}
          selected={this.state.selected}
        />
        <p className="errorText">{this.state.errorMessage}</p>
        <ul className="gamePlayButtons">
          {backButton}
          {confirmButton}
          {deleteButton}
        </ul>
      </div>
    )
  }
}

export default GameplayContainer
