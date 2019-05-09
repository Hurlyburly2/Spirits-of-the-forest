import React from 'react';
import { Link } from 'react-router';

import ScoreCardTile from './ScoreCardTile'
import TokenTile from './TokenTile'

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
  if (props.score.user.branch > props.score.opponent.branch) {
    userBranchClass += " score-winner"
  } else if (props.score.user.branch < props.score.opponent.branch) {
    opponentBranchClass += " score-winner"
  } else {
    userBranchClass += " score-winner"
    opponentBranchClass += " score-winner"
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
  if (props.score.user.dew > props.score.opponent.dew) {
    userDewClass += " score-winner"
  } else if (props.score.user.dew < props.score.opponent.dew) {
    opponentDewClass += " score-winner"
  } else {
    userDewClass += " score-winner"
    opponentDewClass += " score-winner"
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
  if (props.score.user.flower > props.score.opponent.flower) {
    userFlowerClass += " score-winner"
  } else if (props.score.user.flower < props.score.opponent.flower) {
    opponentFlowerClass += " score-winner"
  } else {
    userFlowerClass += " score-winner"
    opponentFlowerClass += " score-winner"
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
  if (props.score.user.fruit > props.score.opponent.fruit) {
    userFruitClass += " score-winner"
  } else if (props.score.user.fruit < props.score.opponent.fruit) {
    opponentFruitClass += " score-winner"
  } else {
    userFruitClass += " score-winner"
    opponentFruitClass += " score-winner"
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
  if (props.score.user.leaf > props.score.opponent.leaf) {
    userLeafClass += " score-winner"
  } else if (props.score.user.leaf < props.score.opponent.leaf) {
    opponentLeafClass += " score-winner"
  } else {
    userLeafClass += " score-winner"
    opponentLeafClass += " score-winner"
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
  if (props.score.user.moss > props.score.opponent.moss) {
    userMossClass += " score-winner"
  } else if (props.score.user.moss < props.score.opponent.moss) {
    opponentMossClass += " score-winner"
  } else {
    userMossClass += " score-winner"
    opponentMossClass += " score-winner"
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
  if (props.score.user.mushroom > props.score.opponent.mushroom) {
    userMushroomClass += " score-winner"
  } else if (props.score.user.mushroom < props.score.opponent.mushroom) {
    opponentMushroomClass += " score-winner"
  } else {
    userMushroomClass += " score-winner"
    opponentMushroomClass += " score-winner"
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
  if (props.score.user.spider > props.score.opponent.spider) {
    userSpiderClass += " score-winner"
  } else if (props.score.user.spider < props.score.opponent.spider) {
    opponentSpiderClass += " score-winner"
  } else {
    userSpiderClass += " score-winner"
    opponentSpiderClass += " score-winner"
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
  if (props.score.user.vine > props.score.opponent.vine) {
    userVineClass += " score-winner"
  } else if (props.score.user.vine < props.score.opponent.vine) {
    opponentVineClass += " score-winner"
  } else {
    userVineClass += " score-winner"
    opponentVineClass += " score-winner"
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
  if (props.score.user.sun > props.score.opponent.sun) {
    userSunClass += " score-winner"
  } else if (props.score.user.sun < props.score.opponent.sun) {
    opponentSunClass += " score-winner"
  } else {
    userSunClass += " score-winner"
    opponentSunClass += " score-winner"
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
  if (props.score.user.moon > props.score.opponent.moon) {
    userMoonClass += " score-winner"
  } else if (props.score.user.moon < props.score.opponent.moon) {
    opponentMoonClass += " score-winner"
  } else {
    userMoonClass += " score-winner"
    opponentMoonClass += " score-winner"
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
  if (props.score.user.wind > props.score.opponent.wind) {
    userWindClass += " score-winner"
  } else if (props.score.user.wind < props.score.opponent.wind) {
    opponentWindClass += " score-winner"
  } else {
    userWindClass += " score-winner"
    opponentWindClass += " score-winner"
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
        endGameMessage = "Opponent Conceded- You Win!"
      } else {
        endGameMessage = "You Conceded- Opponent Wins"
      }
    }
  
  return(
    <div className="score-grid-wrapper">
      <h1>{endGameMessage}</h1>
      <div className="score-grid">
        <div className="score-player-one-name">{props.currentUser.username}</div>
        <div className="score-player-two-name">{props.opponent.username}</div>
        
        <div className="score-icon-branch">branch</div>
        <div className={userBranchClass}>{userBranchCardTiles}</div>
        <div className={opponentBranchClass}>{opponentBranchCardTiles}</div>
        
        <div className="score-icon-dew">dew</div>
        <div className={userDewClass}>{userDewCardTiles}</div>
        <div className={opponentDewClass}>{opponentDewCardTiles}</div>
        
        <div className="score-icon-flower">flower</div>
        <div className={userFlowerClass}>{userFlowerCardTiles}</div>
        <div className={opponentFlowerClass}>{opponentFlowerCardTiles}</div>
        
        <div className="score-icon-fruit">fruit</div>
        <div className={userFruitClass}>{userFruitCardTiles}</div>
        <div className={opponentFruitClass}>{opponentFruitCardTiles}</div>
        
        <div className="score-icon-leaf">leaf</div>
        <div className={userLeafClass}>{userLeafCardTiles}</div>
        <div className={opponentLeafClass}>{opponentLeafCardTiles}</div>
        
        <div className="score-icon-moss">moss</div>
        <div className={userMossClass}>{userMossCardTiles}</div>
        <div className={opponentMossClass}>{opponentMossCardTiles}</div>
        
        <div className="score-icon-mushroom">mushroom</div>
        <div className={userMushroomClass}>{userMushroomCardTiles}</div>
        <div className={opponentMushroomClass}>{opponentMushroomCardTiles}</div>
        
        <div className="score-icon-spider">spider</div>
        <div className={userSpiderClass}>{userSpiderCardTiles}</div>
        <div className={opponentSpiderClass}>{opponentSpiderCardTiles}</div>
        
        <div className="score-icon-vine">vine</div>
        <div className={userVineClass}>{userVineCardTiles}</div>
        <div className={opponentVineClass}>{opponentVineCardTiles}</div>
        
        <div className="score-icon-sun">sun</div>
        <div className={userSunClass}>{userSunCardTiles}</div>
        <div className={opponentSunClass}>{opponentSunCardTiles}</div>
        
        <div className="score-icon-moon">moon</div>
        <div className={userMoonClass}>{userMoonCardTiles}</div>
        <div className={opponentMoonClass}>{opponentMoonCardTiles}</div>
        
        <div className="score-icon-wind">wind</div>
        <div className={userWindClass}>{userWindCardTiles}</div>
        <div className={opponentWindClass}>{opponentWindCardTiles}</div>
        
        <div className="score-icon-total">total</div>
        <div className="score-user-total">{props.score.user.total}</div>
        <div className="score-opponent-total">{props.score.opponent.total}</div>
      </div>
    </div>
  )
}

export default EndGameTile;
