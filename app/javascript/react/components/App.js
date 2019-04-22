import React from 'react'
import { Router, Route, IndexRoute, browserHistory } from 'react-router'

import MyGamesContainer from '../containers/MyGamesContainer'

export const App = (props) => {
  return(
    <Router history={browserHistory}>
      <Route path='/' component={MyGamesContainer} />
    </Router>
  )
}

export default App

// return (<h1>Make It So React</h1>)
