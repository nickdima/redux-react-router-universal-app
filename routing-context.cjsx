React = require 'react'
{ RoutingContext } = require 'react-router'
{ Provider } = require 'react-redux'

store = require './store'

Router = (props) ->
  <Provider store={store}>
    <RoutingContext {...props} />
  </Provider>

module.exports = Router
