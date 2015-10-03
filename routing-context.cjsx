React = require 'react'
{ RoutingContext } = require 'react-router'
{ Provider } = require 'react-redux'

Router = (props) ->
  <Provider store={props.store}>
    <RoutingContext {...props} />
  </Provider>

module.exports = Router
