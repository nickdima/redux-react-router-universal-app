React = require 'react'
{ Route } = require 'react-router'

actions = require './actions'
App = require './screens/app'
User = require './screens/user'

Routes =
  <Route path="/" component={App} action={actions.getContribs}>
    <Route path="user/:name" component={User} action={actions.getUser} />
  </Route>

module.exports = Routes
