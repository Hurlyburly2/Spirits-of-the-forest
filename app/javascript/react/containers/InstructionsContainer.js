import React, { Component } from 'react'

import InstructionsComponent from '../components/InstructionsComponent'

class InstructionsContainer extends Component {
  constructor(props) {
    super(props)
    this.state = {
      
    }
  }
  
  render() {
    return(
      <div>
        <h1>INSTRUCTIONS</h1>
        <InstructionsComponent />
      </div>
    )
  }
}

export default InstructionsContainer
