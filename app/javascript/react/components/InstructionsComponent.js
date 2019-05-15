import React from 'react';
import { Link } from 'react-router';

const InstructionsComponent = (props) => {
  let leftArrowClass = ""
  let rightArrowClass = ""
  if (props.leftArrowHover === true) {
    leftArrowClass = "arrowButton-active"
  }
  if (props.rightArrowHover === true) {
    rightArrowClass = "arrowButton-active"
  }
  
  return(
    <div className="instructions-wrapper">
    <img src="/misc/SOTF-white-logo.png" className="instructions-headerImage"/>
      <div className="instructions-grid">
        <div>
          <img src={props.image} className="instructions-image"/>
        </div>
        <div className="instructions-content">
          {props.content}
        </div>
      </div>
      <div className = "instructions-arrowContainer">
        <img src={props.leftArrow} onClick={props.leftArrowAction} id="leftArrow" className={leftArrowClass}/>
        <img src={props.rightArrow} onClick={props.rightArrowAction} id="rightArrow" className={rightArrowClass}/>
      </div>
    </div>
  )
}

export default InstructionsComponent;

//props: location, player
