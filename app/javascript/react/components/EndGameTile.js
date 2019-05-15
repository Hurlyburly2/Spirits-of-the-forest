import React from 'react';
import { Link } from 'react-router';

import ScoreCardTile from './ScoreCardTile'
import TokenTile from './TokenTile'
import ProfilePic from './ProfilePic'

const EndGameTile = (props) => {
  let userBranchCards = props.yourCards.filter(card => card.spirit === "branch")
  let userBranchCardTiles = userBranchCards.map((card) => {
    return (<ScoreCardTile
      key={card.id}
      id={card.id}
      which_card={card}
      handleSelectCard=""
      selectedClass="score-card"
    />)
  })
  if (props.yourTokens.filter( token => token.spirit === "branch").length > 0) {
    userBranchCardTiles.push(<TokenTile key="yourBranch" token={props.yourTokens.filter( token => token.spirit === "branch")[0]} type="endGameDisplay" whose=""/>)
  }
  
  let opponentBranchCards = props.opponentCards.filter(card => card.spirit === "branch")
  let opponentBranchCardTiles = opponentBranchCards.map((card) => {
    return (<ScoreCardTile
      key={card.id}
      id={card.id}
      which_card={card}
      handleSelectCard=""
      selectedClass="score-card"
    />)
  })
  if (props.opponentTokens.filter( token => token.spirit === "branch").length > 0) {
    opponentBranchCardTiles.push(<TokenTile key="opponentBranch" token={props.opponentTokens.filter( token => token.spirit === "branch")[0]} type="endGameDisplay" whose=""/>)
  }
  
  let userBranchClass = "score-user-branch"
  let opponentBranchClass = "score-opponent-branch"
  let userBranchIcon
  let opponentBranchIcon
  if (props.score.user.branch > props.score.opponent.branch) {
    userBranchClass += " score-winner"
    userBranchIcon = <img src="/tiny-icons/BranchIcon-small.png" className="userBranchIcon"/>
  } else if (props.score.user.branch < props.score.opponent.branch) {
    opponentBranchClass += " score-winner"
    opponentBranchIcon = <img src="/tiny-icons/BranchIcon-small.png" className="opponentBranchIcon"/>
  } else {
    userBranchClass += " score-winner"
    opponentBranchClass += " score-winner"
    userBranchIcon = <img src="/tiny-icons/BranchIcon-small.png" className="userBranchIcon"/>
    opponentBranchIcon = <img src="/tiny-icons/BranchIcon-small.png" className="opponentBranchIcon"/>
  }
  
  let userDewCards = props.yourCards.filter(card => card.spirit === "dew")
  let userDewCardTiles = userDewCards.map((card) => {
    return (<ScoreCardTile
      key={card.id}
      id={card.id}
      which_card={card}
      handleSelectCard=""
      selectedClass="score-card"
    />)
  })
  if (props.yourTokens.filter( token => token.spirit === "dew").length > 0) {
    userDewCardTiles.push(<TokenTile key="yourDew" token={props.yourTokens.filter( token => token.spirit === "dew")[0]} type="endGameDisplay" whose=""/>)
  }
  
  let opponentDewCards = props.opponentCards.filter(card => card.spirit === "dew")
  let opponentDewCardTiles = opponentDewCards.map((card) => {
    return (<ScoreCardTile
      key={card.id}
      id={card.id}
      which_card={card}
      handleSelectCard=""
      selectedClass="score-card"
    />)
  })
  if (props.opponentTokens.filter( token => token.spirit === "dew").length > 0) {
    opponentDewCardTiles.push(<TokenTile key="opponentDew" token={props.opponentTokens.filter( token => token.spirit === "dew")[0]} type="endGameDisplay" whose=""/>)
  }
  
  let userDewClass = "score-user-dew"
  let opponentDewClass = "score-opponent-dew"
  let userDewIcon
  let opponentDewIcon
  if (props.score.user.dew > props.score.opponent.dew) {
    userDewClass += " score-winner"
    userDewIcon = <img src="/tiny-icons/DewIcon-small.png" className="userDewIcon"/>
  } else if (props.score.user.dew < props.score.opponent.dew) {
    opponentDewClass += " score-winner"
    opponentDewIcon = <img src="/tiny-icons/DewIcon-small.png" className="opponentDewIcon"/>
  } else {
    userDewClass += " score-winner"
    opponentDewClass += " score-winner"
    userDewIcon = <img src="/tiny-icons/DewIcon-small.png" className="userDewIcon"/>
    opponentDewIcon = <img src="/tiny-icons/DewIcon-small.png" className="opponentDewIcon"/>
  }
  
  let userFlowerCards = props.yourCards.filter(card => card.spirit === "flower")
  let userFlowerCardTiles = userFlowerCards.map((card) => {
    return (<ScoreCardTile
      key={card.id}
      id={card.id}
      which_card={card}
      handleSelectCard=""
      selectedClass="score-card"
    />)
  })
  if (props.yourTokens.filter( token => token.spirit === "flower").length > 0) {
    userFlowerCardTiles.push(<TokenTile key="yourFlower" token={props.yourTokens.filter( token => token.spirit === "flower")[0]} type="endGameDisplay" whose=""/>)
  }
  
  let opponentFlowerCards = props.opponentCards.filter(card => card.spirit === "flower")
  let opponentFlowerCardTiles = opponentFlowerCards.map((card) => {
    return (<ScoreCardTile
      key={card.id}
      id={card.id}
      which_card={card}
      handleSelectCard=""
      selectedClass="score-card"
    />)
  })
  if (props.opponentTokens.filter( token => token.spirit === "flower").length > 0) {
    opponentFlowerCardTiles.push(<TokenTile key="opponentFlower" token={props.opponentTokens.filter( token => token.spirit === "flower")[0]} type="endGameDisplay" whose=""/>)
  }
  
  let userFlowerClass = "score-user-flower"
  let opponentFlowerClass = "score-opponent-flower"
  let userFlowerIcon
  let opponentFlowerIcon
  if (props.score.user.flower > props.score.opponent.flower) {
    userFlowerClass += " score-winner"
    userFlowerIcon = <img src="/tiny-icons/FlowerIcon-small.png" className="userFlowerIcon"/>
  } else if (props.score.user.flower < props.score.opponent.flower) {
    opponentFlowerClass += " score-winner"
    opponentFlowerIcon = <img src="/tiny-icons/FlowerIcon-small.png" className="opponentFlowerIcon"/>
  } else {
    userFlowerClass += " score-winner"
    opponentFlowerClass += " score-winner"
    userFlowerIcon = <img src="/tiny-icons/FlowerIcon-small.png" className="userFlowerIcon"/>
    opponentFlowerIcon = <img src="/tiny-icons/FlowerIcon-small.png" className="opponentFlowerIcon"/>
  }
  
  let userFruitCards = props.yourCards.filter(card => card.spirit === "fruit")
  let userFruitCardTiles = userFruitCards.map((card) => {
    return (<ScoreCardTile
      key={card.id}
      id={card.id}
      which_card={card}
      handleSelectCard=""
      selectedClass="score-card"
    />)
  })
  if (props.yourTokens.filter( token => token.spirit === "fruit").length > 0) {
    userFruitCardTiles.push(<TokenTile key="yourFruit" token={props.yourTokens.filter( token => token.spirit === "fruit")[0]} type="endGameDisplay" whose=""/>)
  }
  
  let opponentFruitCards = props.opponentCards.filter(card => card.spirit === "fruit")
  let opponentFruitCardTiles = opponentFruitCards.map((card) => {
    return (<ScoreCardTile
      key={card.id}
      id={card.id}
      which_card={card}
      handleSelectCard=""
      selectedClass="score-card"
    />)
  })
  if (props.opponentTokens.filter( token => token.spirit === "fruit").length > 0) {
    opponentFruitCardTiles.push(<TokenTile key="opponentFruit" token={props.opponentTokens.filter( token => token.spirit === "fruit")[0]} type="endGameDisplay" whose=""/>)
  }
  
  let userFruitClass = "score-user-fruit"
  let opponentFruitClass = "score-opponent-fruit"
  let userFruitIcon
  let opponentFruitIcon
  if (props.score.user.fruit > props.score.opponent.fruit) {
    userFruitClass += " score-winner"
    userFruitIcon = <img src="/tiny-icons/FruitIcon-small.png" className="userFruitIcon"/>
  } else if (props.score.user.fruit < props.score.opponent.fruit) {
    opponentFruitClass += " score-winner"
    opponentFruitIcon = <img src="/tiny-icons/FruitIcon-small.png" className="opponentFruitIcon"/>
  } else {
    userFruitClass += " score-winner"
    opponentFruitClass += " score-winner"
    userFruitIcon = <img src="/tiny-icons/FruitIcon-small.png" className="userFruitIcon"/>
    opponentFruitIcon = <img src="/tiny-icons/FruitIcon-small.png" className="opponentFruitIcon"/>
  }
  
  let userLeafCards = props.yourCards.filter(card => card.spirit === "leaf")
  let userLeafCardTiles = userLeafCards.map((card) => {
    return (<ScoreCardTile
      key={card.id}
      id={card.id}
      which_card={card}
      handleSelectCard=""
      selectedClass="score-card"
    />)
  })
  if (props.yourTokens.filter( token => token.spirit === "leaf").length > 0) {
    userLeafCardTiles.push(<TokenTile key="yourLeaf" token={props.yourTokens.filter( token => token.spirit === "leaf")[0]} type="endGameDisplay" whose=""/>)
  }
  
  let opponentLeafCards = props.opponentCards.filter(card => card.spirit === "leaf")
  let opponentLeafCardTiles = opponentLeafCards.map((card) => {
    return (<ScoreCardTile
      key={card.id}
      id={card.id}
      which_card={card}
      handleSelectCard=""
      selectedClass="score-card"
    />)
  })
  if (props.opponentTokens.filter( token => token.spirit === "leaf").length > 0) {
    opponentLeafCardTiles.push(<TokenTile key="opponentLeaf" token={props.opponentTokens.filter( token => token.spirit === "leaf")[0]} type="endGameDisplay" whose=""/>)
  }
  
  let userLeafClass = "score-user-leaf"
  let opponentLeafClass = "score-opponent-leaf"
  let userLeafIcon
  let opponentLeafIcon
  if (props.score.user.leaf > props.score.opponent.leaf) {
    userLeafClass += " score-winner"
    userLeafIcon = <img src="/tiny-icons/LeafIcon-small.png" className="userLeafIcon"/>
  } else if (props.score.user.leaf < props.score.opponent.leaf) {
    opponentLeafClass += " score-winner"
    opponentLeafIcon = <img src="/tiny-icons/LeafIcon-small.png" className="opponentLeafIcon"/>
  } else {
    userLeafClass += " score-winner"
    opponentLeafClass += " score-winner"
    userLeafIcon = <img src="/tiny-icons/LeafIcon-small.png" className="userLeafIcon"/>
    opponentLeafIcon = <img src="/tiny-icons/LeafIcon-small.png" className="opponentLeafIcon"/>
  }
  
  let userMossCards = props.yourCards.filter(card => card.spirit === "moss")
  let userMossCardTiles = userMossCards.map((card) => {
    return (<ScoreCardTile
      key={card.id}
      id={card.id}
      which_card={card}
      handleSelectCard=""
      selectedClass="score-card"
    />)
  })
  if (props.yourTokens.filter( token => token.spirit === "moss").length > 0) {
    userMossCardTiles.push(<TokenTile key="yourMoss" token={props.yourTokens.filter( token => token.spirit === "moss")[0]} type="endGameDisplay" whose=""/>)
  }
  
  let opponentMossCards = props.opponentCards.filter(card => card.spirit === "moss")
  let opponentMossCardTiles = opponentMossCards.map((card) => {
    return (<ScoreCardTile
      key={card.id}
      id={card.id}
      which_card={card}
      handleSelectCard=""
      selectedClass="score-card"
    />)
  })
  if (props.opponentTokens.filter( token => token.spirit === "moss").length > 0) {
    opponentMossCardTiles.push(<TokenTile key="opponentMoss" token={props.opponentTokens.filter( token => token.spirit === "moss")[0]} type="endGameDisplay" whose=""/>)
  }
  
  let userMossClass = "score-user-moss"
  let opponentMossClass = "score-opponent-moss"
  let userMossIcon
  let opponentMossIcon
  if (props.score.user.moss > props.score.opponent.moss) {
    userMossClass += " score-winner"
    userMossIcon = <img src="/tiny-icons/MossIcon-small.png" className="userMossIcon"/>
  } else if (props.score.user.moss < props.score.opponent.moss) {
    opponentMossClass += " score-winner"
    opponentMossIcon = <img src="/tiny-icons/MossIcon-small.png" className="opponentMossIcon"/>
  } else {
    userMossClass += " score-winner"
    opponentMossClass += " score-winner"
    userMossIcon = <img src="/tiny-icons/MossIcon-small.png" className="userMossIcon"/>
    opponentMossIcon = <img src="/tiny-icons/MossIcon-small.png" className="opponentMossIcon"/>
  }
  
  let userMushroomCards = props.yourCards.filter(card => card.spirit === "mushroom")
  let userMushroomCardTiles = userMushroomCards.map((card) => {
    return (<ScoreCardTile
      key={card.id}
      id={card.id}
      which_card={card}
      handleSelectCard=""
      selectedClass="score-card"
    />)
  })
  if (props.yourTokens.filter( token => token.spirit === "mushroom").length > 0) {
    userMushroomCardTiles.push(<TokenTile key="yourMushroom" token={props.yourTokens.filter( token => token.spirit === "mushroom")[0]} type="endGameDisplay" whose=""/>)
  }
  
  let opponentMushroomCards = props.opponentCards.filter(card => card.spirit === "mushroom")
  let opponentMushroomCardTiles = opponentMushroomCards.map((card) => {
    return (<ScoreCardTile
      key={card.id}
      id={card.id}
      which_card={card}
      handleSelectCard=""
      selectedClass="score-card"
    />)
  })
  if (props.opponentTokens.filter( token => token.spirit === "mushroom").length > 0) {
    opponentMushroomCardTiles.push(<TokenTile key="opponentMushroom" token={props.opponentTokens.filter( token => token.spirit === "mushroom")[0]} type="endGameDisplay" whose=""/>)
  }
  
  let userMushroomClass = "score-user-mushroom"
  let opponentMushroomClass = "score-opponent-mushroom"
  let userMushroomIcon
  let opponentMushroomIcon
  if (props.score.user.mushroom > props.score.opponent.mushroom) {
    userMushroomClass += " score-winner"
    userMushroomIcon = <img src="/tiny-icons/MushroomIcon-small.png" className="userMushroomIcon"/>
  } else if (props.score.user.mushroom < props.score.opponent.mushroom) {
    opponentMushroomClass += " score-winner"
    opponentMushroomIcon = <img src="/tiny-icons/MushroomIcon-small.png" className="opponentMushroomIcon"/>
  } else {
    userMushroomClass += " score-winner"
    opponentMushroomClass += " score-winner"
    userMushroomIcon = <img src="/tiny-icons/MushroomIcon-small.png" className="userMushroomIcon"/>
    opponentMushroomIcon = <img src="/tiny-icons/MushroomIcon-small.png" className="opponentMushroomIcon"/>
  }
  
  let userSpiderCards = props.yourCards.filter(card => card.spirit === "spider")
  let userSpiderCardTiles = userSpiderCards.map((card) => {
    return (<ScoreCardTile
      key={card.id}
      id={card.id}
      which_card={card}
      handleSelectCard=""
      selectedClass="score-card"
    />)
  })
  if (props.yourTokens.filter( token => token.spirit === "spider").length > 0) {
    userSpiderCardTiles.push(<TokenTile key="yourSpider" token={props.yourTokens.filter( token => token.spirit === "spider")[0]} type="endGameDisplay" whose=""/>)
  }
  
  let opponentSpiderCards = props.opponentCards.filter(card => card.spirit === "spider")
  let opponentSpiderCardTiles = opponentSpiderCards.map((card) => {
    return (<ScoreCardTile
      key={card.id}
      id={card.id}
      which_card={card}
      handleSelectCard=""
      selectedClass="score-card"
    />)
  })
  if (props.opponentTokens.filter( token => token.spirit === "spider").length > 0) {
    opponentSpiderCardTiles.push(<TokenTile key="opponentSpider" token={props.opponentTokens.filter( token => token.spirit === "spider")[0]} type="endGameDisplay" whose=""/>)
  }
  
  let userSpiderClass = "score-user-spider"
  let opponentSpiderClass = "score-opponent-spider"
  let userSpiderIcon
  let opponentSpiderIcon
  if (props.score.user.spider > props.score.opponent.spider) {
    userSpiderClass += " score-winner"
    userSpiderIcon = <img src="/tiny-icons/SpiderIcon-Small.png" className="userSpiderIcon"/>
  } else if (props.score.user.spider < props.score.opponent.spider) {
    opponentSpiderClass += " score-winner"
    opponentSpiderIcon = <img src="/tiny-icons/SpiderIcon-Small.png" className="opponentSpiderIcon"/>
  } else {
    userSpiderClass += " score-winner"
    opponentSpiderClass += " score-winner"
    userSpiderIcon = <img src="/tiny-icons/SpiderIcon-Small.png" className="userSpiderIcon"/>
    opponentSpiderIcon = <img src="/tiny-icons/SpiderIcon-Small.png" className="opponentSpiderIcon"/>
  }
  
  let userVineCards = props.yourCards.filter(card => card.spirit === "vine")
  let userVineCardTiles = userVineCards.map((card) => {
    return (<ScoreCardTile
      key={card.id}
      id={card.id}
      which_card={card}
      handleSelectCard=""
      selectedClass="score-card"
    />)
  })
  if (props.yourTokens.filter( token => token.spirit === "vine").length > 0) {
    userVineCardTiles.push(<TokenTile key="yourVine" token={props.yourTokens.filter( token => token.spirit === "vine")[0]} type="endGameDisplay" whose=""/>)
  }
  
  let opponentVineCards = props.opponentCards.filter(card => card.spirit === "vine")
  let opponentVineCardTiles = opponentVineCards.map((card) => {
    return (<ScoreCardTile
      key={card.id}
      id={card.id}
      which_card={card}
      handleSelectCard=""
      selectedClass="score-card"
    />)
  })
  if (props.opponentTokens.filter( token => token.spirit === "vine").length > 0) {
    opponentVineCardTiles.push(<TokenTile key="opponentVine" token={props.opponentTokens.filter( token => token.spirit === "vine")[0]} type="endGameDisplay" whose=""/>)
  }
  
  let userVineClass = "score-user-vine"
  let opponentVineClass = "score-opponent-vine"
  let userVineIcon
  let opponentVineIcon
  if (props.score.user.vine > props.score.opponent.vine) {
    userVineClass += " score-winner"
    userVineIcon = <img src="/tiny-icons/VineIcon-Small.png" className="userVineIcon"/>
  } else if (props.score.user.vine < props.score.opponent.vine) {
    opponentVineClass += " score-winner"
    opponentVineIcon = <img src="/tiny-icons/VineIcon-Small.png" className="opponentVineIcon"/>
  } else {
    userVineClass += " score-winner"
    opponentVineClass += " score-winner"
    userVineIcon = <img src="/tiny-icons/VineIcon-Small.png" className="userVineIcon"/>
    opponentVineIcon = <img src="/tiny-icons/VineIcon-Small.png" className="opponentVineIcon"/>
  }
  
  let userSunCards = props.yourCards.filter(card => card.element === "sun")
  let userSunCardTiles = userSunCards.map((card) => {
  let sunCardId = `sun${card.id}`
  return (<ScoreCardTile
    key={sunCardId}
    id={sunCardId}
    which_card={card}
    handleSelectCard=""
    selectedClass="score-card"
    />)
  })
  if (props.yourTokens.filter( token => token.spirit === "sun").length > 0) {
    userSunCardTiles.push(<TokenTile key="yourSun" token={props.yourTokens.filter( token => token.spirit === "sun")[0]} type="endGameDisplay" whose=""/>)
  }
  
  let opponentSunCards = props.opponentCards.filter(card => card.element === "sun")
  let opponentSunCardTiles = opponentSunCards.map((card) => {
  let sunCardId = `sun${card.id}`
  return (<ScoreCardTile
    key={sunCardId}
    id={sunCardId}
    which_card={card}
    handleSelectCard=""
    selectedClass="score-card"
    />)
  })
  if (props.opponentTokens.filter( token => token.spirit === "sun").length > 0) {
    opponentSunCardTiles.push(<TokenTile key="opponentSun" token={props.opponentTokens.filter( token => token.spirit === "sun")[0]} type="endGameDisplay" whose=""/>)
  }
    
  let userSunClass = "score-user-sun"
  let opponentSunClass = "score-opponent-sun"
  let userSunIcon
  let opponentSunIcon
  if (props.score.user.sun > props.score.opponent.sun) {
    userSunClass += " score-winner"
    userSunIcon = <img src="/tiny-icons/SunIcon-Small.png" className="userSunIcon"/>
  } else if (props.score.user.sun < props.score.opponent.sun) {
    opponentSunClass += " score-winner"
    opponentSunIcon = <img src="/tiny-icons/SunIcon-Small.png" className="opponentSunIcon"/>
  } else {
    userSunClass += " score-winner"
    opponentSunClass += " score-winner"
    userSunIcon = <img src="/tiny-icons/SunIcon-Small.png" className="userSunIcon"/>
    opponentSunIcon = <img src="/tiny-icons/SunIcon-Small.png" className="opponentSunIcon"/>
  }
  
  let userMoonCards = props.yourCards.filter(card => card.element === "moon")
  let userMoonCardTiles = userMoonCards.map((card) => {
  let moonCardId = `moon${card.id}`
  return (<ScoreCardTile
    key={moonCardId}
    id={moonCardId}
    which_card={card}
    handleSelectCard=""
    selectedClass="score-card"
    />)
  })
  if (props.yourTokens.filter( token => token.spirit === "moon").length > 0) {
    userMoonCardTiles.push(<TokenTile key="yourMoon" token={props.yourTokens.filter( token => token.spirit === "moon")[0]} type="endGameDisplay" whose=""/>)
  }

  let opponentMoonCards = props.opponentCards.filter(card => card.element === "moon")
  let opponentMoonCardTiles = opponentMoonCards.map((card) => {
  let moonCardId = `moon${card.id}`
  return (<ScoreCardTile
    key={moonCardId}
    id={moonCardId}
    which_card={card}
    handleSelectCard=""
    selectedClass="score-card"
    />)
  })
  if (props.opponentTokens.filter( token => token.spirit === "moon").length > 0) {
    opponentMoonCardTiles.push(<TokenTile key="opponentMoon" token={props.opponentTokens.filter( token => token.spirit === "moon")[0]} type="endGameDisplay" whose=""/>)
  }
  
  let userMoonClass = "score-user-moon"
  let opponentMoonClass = "score-opponent-moon"
  let userMoonIcon
  let opponentMoonIcon
  if (props.score.user.moon > props.score.opponent.moon) {
    userMoonClass += " score-winner"
    userMoonIcon = <img src="/tiny-icons/MoonIcon-small.png" className="userMoonIcon"/>
  } else if (props.score.user.moon < props.score.opponent.moon) {
    opponentMoonClass += " score-winner"
    opponentMoonIcon = <img src="/tiny-icons/MoonIcon-small.png" className="opponentMoonIcon"/>
  } else {
    userMoonClass += " score-winner"
    opponentMoonClass += " score-winner"
    userMoonIcon = <img src="/tiny-icons/MoonIcon-small.png" className="userMoonIcon"/>
    opponentMoonIcon = <img src="/tiny-icons/MoonIcon-small.png" className="opponentMoonIcon"/>
  }
  
  let userWindCards = props.yourCards.filter(card => card.element === "wind")
  let userWindCardTiles = userWindCards.map((card) => {
  let windCardId = `wind${card.id}`
  return (<ScoreCardTile
    key={windCardId}
    id={windCardId}
    which_card={card}
    handleSelectCard=""
    selectedClass="score-card"
    />)
  })
  if (props.yourTokens.filter( token => token.spirit === "wind").length > 0) {
    userWindCardTiles.push(<TokenTile key="yourWind" token={props.yourTokens.filter( token => token.spirit === "wind")[0]} type="endGameDisplay" whose=""/>)
  }
  
  let opponentWindCards = props.opponentCards.filter(card => card.element === "wind")
  let opponentWindCardTiles = opponentWindCards.map((card) => {
  let windCardId = `wind${card.id}`
  return (<ScoreCardTile
    key={windCardId}
    id={windCardId}
    which_card={card}
    handleSelectCard=""
    selectedClass="score-card"
    />)
  })
  if (props.opponentTokens.filter( token => token.spirit === "wind").length > 0) {
    opponentWindCardTiles.push(<TokenTile key="opponentWind" token={props.opponentTokens.filter( token => token.spirit === "wind")[0]} type="endGameDisplay" whose=""/>)
  }
  
  let userWindClass = "score-user-wind"
  let opponentWindClass = "score-opponent-wind"
  let userWindIcon
  let opponentWindIcon
  if (props.score.user.wind > props.score.opponent.wind) {
    userWindClass += " score-winner"
    userWindIcon = <img src="/tiny-icons/WindIcon-Small.png" className="userWindIcon"/>
  } else if (props.score.user.wind < props.score.opponent.wind) {
    opponentWindClass += " score-winner"
    opponentWindIcon = <img src="/tiny-icons/WindIcon-Small.png" className="opponentWindIcon"/>
  } else {
    userWindClass += " score-winner"
    opponentWindClass += " score-winner"
    userWindIcon = <img src="/tiny-icons/WindIcon-Small.png" className="userWindIcon"/>
    opponentWindIcon = <img src="/tiny-icons/WindIcon-Small.png" className="opponentWindIcon"/>
  }
    
    let endGameMessage
    if (props.concession === false) {
      if (props.score.user.total > props.score.opponent.total) {
        endGameMessage = "You Win!"
      } else if (props.score.user.total < props.score.opponent.total) {
        endGameMessage = "You Lose"
      } else {
        endGameMessage = "Tie Game!"
      }
    } else {
      if (props.currentUser.username === props.winner.username) {
        endGameMessage = <div>Concession:<br /> You Win!</div>
      } else {
        endGameMessage = <div>Concession:<br /> You Lose</div>
      }
    }
    
    let playerName = <div className="gameplayCurrentPlayerBox scoreScreenPlayerBox">
        <ProfilePic key="ProfilePic" whichPic={props.currentUser.which_profile_pic} whichRank={props.currentUser.rank} where="GameplayBottomUser" who="player"/>
        <div className="gameplay-CurrentPlayerBox-Content">
          <h4>{props.currentUser.username}</h4>
        </div>
      </div>
    
    let opponentName = <div className="gameplayOpponentPlayerBox scoreScreenOpponentBox">
      <ProfilePic key="ProfilePic" whichPic={props.opponent.which_profile_pic} whichRank={props.opponent.rank} where="GameplayOpponent" who="player"/>
      <div className="gameplay-OpponentPlayerBox-Content">
        <h4>{props.opponent.username}</h4>
      </div>
    </div>
  
  return(
    <div className="score-grid-wrapper">
      <div className = "gameplayBottomWrapper">
        {playerName}<h4 className="whoseTurn"><span className="endGame-Message">{endGameMessage}</span></h4>{opponentName}
      </div>
      <div id="score-user-total">{props.score.user.total}</div>
      <div id="score-text-total">Total</div>
      <div id="score-opponent-total">{props.score.opponent.total}</div>
      <div className = "grid-container">
        <div className="score-grid">
          
          <hr className = "branchLine" />
          
          <div className={userBranchClass}>{userBranchCardTiles}</div>
          {userBranchIcon}
          <div className="score-text-branch">Branch</div>
          {opponentBranchIcon}
          <div className={opponentBranchClass}>{opponentBranchCardTiles}</div>
          
          <hr className = "dewLine" />
          
          <div className={userDewClass}>{userDewCardTiles}</div>
          {userDewIcon}
          <div className="score-text-dew">Dew</div>
          {opponentDewIcon}
          <div className={opponentDewClass}>{opponentDewCardTiles}</div>
          
          <hr className = "flowerLine" />
          
          <div className={userFlowerClass}>{userFlowerCardTiles}</div>
          {userFlowerIcon}
          <div className="score-text-flower">Flower</div>
          {opponentFlowerIcon}
          <div className={opponentFlowerClass}>{opponentFlowerCardTiles}</div>
          
          <hr className = "fruitLine" />
          
          <div className={userFruitClass}>{userFruitCardTiles}</div>
          {userFruitIcon}
          <div className="score-text-fruit">Fruit</div>
          {opponentFruitIcon}
          <div className={opponentFruitClass}>{opponentFruitCardTiles}</div>
          
          <hr className = "leafLine" />
          
          <div className={userLeafClass}>{userLeafCardTiles}</div>
          {userLeafIcon}
          <div className="score-text-leaf">Leaf</div>
          {opponentLeafIcon}
          <div className={opponentLeafClass}>{opponentLeafCardTiles}</div>
          
          <hr className = "mossLine" />
          
          <div className={userMossClass}>{userMossCardTiles}</div>
          {userMossIcon}
          <div className="score-text-moss">Moss</div>
          {opponentMossIcon}
          <div className={opponentMossClass}>{opponentMossCardTiles}</div>
          
          <hr className = "mushroomLine" />
          
          <div className={userMushroomClass}>{userMushroomCardTiles}</div>
          {userMushroomIcon}
          <div className="score-text-mushroom">Mushroom</div>
          {opponentMushroomIcon}
          <div className={opponentMushroomClass}>{opponentMushroomCardTiles}</div>
          
          <hr className = "spiderLine" />
          
          <div className={userSpiderClass}>{userSpiderCardTiles}</div>
          {userSpiderIcon}
          <div className="score-text-spider">Spider</div>
          {opponentSpiderIcon}
          <div className={opponentSpiderClass}>{opponentSpiderCardTiles}</div>
          
          <hr className = "vineLine" />
          
          <div className={userVineClass}>{userVineCardTiles}</div>
          {userVineIcon}
          <div className="score-text-vine">Vine</div>
          {opponentVineIcon}
          <div className={opponentVineClass}>{opponentVineCardTiles}</div>
          
          <hr className = "sunLine" />
          
          <div className={userSunClass}>{userSunCardTiles}</div>
          {userSunIcon}
          <div className="score-text-sun">Sun</div>
          {opponentSunIcon}
          <div className={opponentSunClass}>{opponentSunCardTiles}</div>
          
          <hr className = "moonLine" />
          
          <div className={userMoonClass}>{userMoonCardTiles}</div>
          {userMoonIcon}
          <div className="score-text-moon">Moon</div>
          {opponentMoonIcon}
          <div className={opponentMoonClass}>{opponentMoonCardTiles}</div>
          
          <hr className = "windLine" />
          
          <div className={userWindClass}>{userWindCardTiles}</div>
          {userWindIcon}
          <div className="score-text-wind">Wind</div>
          {opponentWindIcon}
          <div className={opponentWindClass}>{opponentWindCardTiles}</div>
          
        </div>
      </div>
    </div>
  )
}

export default EndGameTile;
