import React from 'react';
import { Link } from 'react-router';

const InstructionsComponent = (props) => {
  
  return(
    <div>
      <img src="/misc/SOTF-white-logo.png" />
      <div>
        <img src={props.image} />
      </div>
      <div>
        {props.content}
      </div>
      <div>
        <img src={props.leftArrow} onClick={props.leftArrowAction} />
        <img src={props.rightArrow} onClick={props.rightArrowAction} />
      </div>
    </div>
  )
}

export default InstructionsComponent;

//props: location, player
