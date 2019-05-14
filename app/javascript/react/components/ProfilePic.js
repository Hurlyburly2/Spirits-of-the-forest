import React from 'react';
import { Link } from 'react-router';

const ProfilePic = (props) => {
  // whichPic={props.current_player.which_profile_pic}
  //  whichRank={props.current_player.rank} 
  //  where="GameTile"/>
  let image_url = "/rankicons/"
  
  if (props.where === "GameTile") {
    if (props.whichPic === 1) {
      image_url = image_url + "Branch"
    } else if (props.whichPic === 2) {
      image_url = image_url + "Dew"
    } else if (props.whichPic === 3) {
      image_url = image_url + "Flower"
    } else if (props.whichPic === 4) {
      image_url = image_url + "Fruit"
    } else if (props.whichPic === 5) {
      image_url = image_url + "Moss"
    } else if (props.whichPic === 6) {
      image_url = image_url + "Mushroom"
    } else if (props.whichPic === 7) {
      image_url = image_url + "Moon"
    } else if (props.whichPic === 8) {
      image_url = image_url + "Spider"
    } else if (props.whichPic === 9) {
      image_url = image_url + "Vine"
    } else if (props.whichPic === 10) {
      image_url = image_url + "Leaf"
    } else if (props.whichPic === 11) {
      image_url = image_url + "Sun"
    } else if (props.whichPic === 12) {
      image_url = image_url + "Wind"
    }

    if (props.whichRank === "bronze") {
      image_url = image_url + "Bronze"
    } else if (props.whichRank === "silver") {
      image_url = image_url + "Silver"
    } else if (props.whichRank === "gold") {
      image_url = image_url + "Gold"
    } else if (props.whichRank === "diamon") {
      image_url = image_url + "Diamond"
    } else {
      image_url = image_url + "master"
    }
    
    if (props.whichPic === "unknown") {
      image_url = "/rankicons/Unknown-Opponent"
    }
  } else if (props.where === "GamePage") {
      image_url = "/tokens/"
      if (props.whichPic === 1) {
        image_url = image_url + "Branch"
      } else if (props.whichPic === 2) {
        image_url = image_url + "Dew"
      } else if (props.whichPic === 3) {
        image_url = image_url + "Flower"
      } else if (props.whichPic === 4) {
        image_url = image_url + "Fruit"
      } else if (props.whichPic === 5) {
        image_url = image_url + "Moss"
      } else if (props.whichPic === 6) {
        image_url = image_url + "Mushroom"
      } else if (props.whichPic === 7) {
        image_url = image_url + "Moon"
      } else if (props.whichPic === 8) {
        image_url = image_url + "Spider"
      } else if (props.whichPic === 9) {
        image_url = image_url + "Vine"
      } else if (props.whichPic === 10) {
        image_url = image_url + "Leaf"
      } else if (props.whichPic === 11) {
        image_url = image_url + "Sun"
      } else if (props.whichPic === 12) {
        image_url = image_url + "Wind"
      }
      image_url = image_url + "Token"
  }
  
  let image_class = ""
  if (props.where === "GameTile") {
    if (props.who === "player") {
      image_class = "gameTile-left-image"
    } else if (props.who === "opponent") {
      image_class = "gameTile-right-image"
    }
  } else if (props.where === "GamePage") {
    image_class = "gameIndex-profilePic"
  }
  
  image_url = image_url + ".png"
  
  return(
    <img src={image_url} className={image_class}/>
  )
}

export default ProfilePic;

// <img src={display_card} className={cardClass} onClick={props.handleSelectCard} id={props.id} />
