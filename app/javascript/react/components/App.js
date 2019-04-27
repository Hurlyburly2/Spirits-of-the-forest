import React from 'react'
import { Router, Route, IndexRoute, browserHistory } from 'react-router'

import MyGamesContainer from '../containers/MyGamesContainer'
import AccountContainer from '../containers/AccountContainer'
import JoinGameContainer from '../containers/JoinGameContainer'

export const App = (props) => {
  return(
    <Router history={browserHistory}>
      <Route path='/' component={MyGamesContainer} />
      <Route path='/Account' component={AccountContainer} />
      <Route path='/matches' component={JoinGameContainer} />
    </Router>
  )
}

export default App

// return (<h1>Make It So React</h1>)
