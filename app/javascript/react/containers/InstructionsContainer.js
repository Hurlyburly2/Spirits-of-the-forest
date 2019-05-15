import React, { Component } from 'react'

import InstructionsComponent from '../components/InstructionsComponent'

class InstructionsContainer extends Component {
  constructor(props) {
    super(props)
    this.state = {
      whichPage: 1
    }
    this.handleClickLeft = this.handleClickLeft.bind(this)
    this.handleClickRight = this.handleClickRight.bind(this)
  }
  
  handleClickLeft() {
    this.setState({ whichPage: this.state.whichPage - 1 })
  }
  
  handleClickRight() {
    this.setState({ whichPage: this.state.whichPage + 1 })
  }
  
  render() {
    let content
    let image
    let leftArrow
    let rightArrow
    let leftArrowAction
    let rightArrowAction
    let leftArrowHover
    let rightArrowHover
    
    if (this.state.whichPage === 1) {
      content = <div>
        <h1>How to Play</h1>
        <p>In Spirits of the Forest, players each represent an element that nourishes the forces of nature.
Players compete to acquire the most spirit symbols and score points for having the majority of
each spirit. The winner is the player with the most points at the end of the game.</p>
        <h2>Spirit Cards</h2>
        <p>The Spirit Cards represent the nine different spirits of the forest. Each spirit is associated with a unique color and unique spirit animal. Each spirit card has one or two icons at the top that are either a spirit symbol (1) or one of three power source icons (2) - the fierceness of wind, the mysticism of the moon, and the life-giving power of the sun.
Each spirit card also features a number at the bottom of the card (3) that signifies how many spirit symbols of that spirit exist in the deck.</p>
      </div>
      image = "/instructions/CardParts.png"
      leftArrow = "/instructions/ArrowGray-Left.png"
      leftArrowHover = false
      rightArrow = "/instructions/ArrowGreen-Right.png"
      rightArrowAction = () => { this.handleClickRight() }
      rightArrowHover = true
    } else if (this.state.whichPage === 2) {
      content = <div>
        <h1>How to Play</h1>
        <p>On each turn, a player collects cards, and places gemstones.</p>
        <h2>Collect Cards:</h2>
        <p>On each turn, the player collects cards from either of the two ends of the forest, choosing one of the following actions:</p>
        <ol>
          <li>Take up to two tiles of the same color that have only one spirit symbol.</li>
          <li>Take a tile with two spirit symbols on it</li>
        </ol>
        <p>Taking two adjacent tiles with one spirit symbol on each IS allowed- by taking the first, the adjacent will become the “end of the forest.” (3)
After collecting cards, the player adds them to their collection, where they can be viewed by clicking the player’s name. If the player is unable to collect any tiles, their turn is skipped.</p>
      </div>
      image = "/instructions/LegalMoves.png"
      leftArrow = "/instructions/ArrowGreen-Left.png"
      leftArrowAction = () => { this.handleClickLeft() }
      leftArrowHover = true
      rightArrow = "/instructions/ArrowGreen-Right.png"
      rightArrowAction = () => { this.handleClickRight() }
      rightArrowHover = true
    } else if (this.state.whichPage === 3) {
      content = <div>
        <h1>How to Play</h1>
        <h2>Favor Tokens:</h2>
        <p>If a player collected a tile with a favor token on it (1), they also also acquire that token to their
collection. If it has a spirit symbol (2) or power source icon (3), it remains hidden from the other player until the end of the game and counts as an additional symbol or power source when scoring.
Favor symbols with the ‘+’ icon give you an extra gem. (4)</p>
      </div>
      image = "/instructions/TokenGuide.png"
      leftArrow = "/instructions/ArrowGreen-Left.png"
      leftArrowAction = () => { this.handleClickLeft() }
      leftArrowHover = true
      rightArrow = "/instructions/ArrowGreen-Right.png"
      rightArrowAction = () => { this.handleClickRight() }
      rightArrowHover = true
    } else if (this.state.whichPage === 4) {
      content = <div>
        <h1>How to Play</h1>
        <h2>Place Gemstones</h2>
        <p>Once per turn, a player may choose to put one of their gemstones(1) on a card in the forest (2) or to move a gemstone that is already placed. By placing a gemstone on a spirit card, that player attempts to reserve that tile for a future turn. Their opponent may not select that card even if it would ordinarily be a legal move. If the player who placed the gemstone collects that card, they get that stone back to use again.
To collect a card with an opponent’s gemstone on it, a player must remove one of their own gemstones permanently from the game. The opponent then gets their gemstone back for future use. If all of a player’s gemstones are removed from the game, they cannot collect cards that have been reserved by their opponent.</p>
      </div>
      image = "/instructions/GemGuide.png"
      leftArrow = "/instructions/ArrowGreen-Left.png"
      leftArrowHover = true
      leftArrowAction = () => { this.handleClickLeft() }
      rightArrow = "/instructions/ArrowGreen-Right.png"
      rightArrowAction = () => { this.handleClickRight() }
      rightArrowHover = true
    } else if (this.state.whichPage === 5) {
      content = <div>
        <h1>How to Play</h1>
        <h2>End of the Game:</h2>
        <p>Players take turns until all cards have been collected from the forest, then points are scored:</p>
        <ol>
          <li>Spirits: A player with the highest score for a particular spirit scores points equal to the amount of spirit symbols for that spirit they’ve collected (1). This is tallied for all nine spirits. If players are tied for the most spirit symbols for a spirit (2), they both get points equal to the amount of spirit symbols they have. If a player has zero spirits for a particular type, they get 3 points subtracted from their total.</li>
          <li>Power Sources: Power sources (wind, sun, and moon) are scored in the same way as spirits (3).</li>
          <li>The player with the most points wins!</li>
        </ol>
      </div>
      image = "/instructions/ScoreGuide.png"
      leftArrow = "/instructions/ArrowGreen-Left.png"
      leftArrowAction = () => { this.handleClickLeft() }
      leftArrowHover = true
      rightArrow = "/instructions/ArrowGray-Right.png"
      rightArrowHover = false
    }
    
    return(
      <div>
        <InstructionsComponent content={content} image={image} leftArrow={leftArrow} rightArrow={rightArrow} leftArrowAction={leftArrowAction} rightArrowAction={rightArrowAction} leftArrowHover={leftArrowHover} rightArrowHover={rightArrowHover}/>
      </div>
    )
  }
}

export default InstructionsContainer
