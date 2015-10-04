React = require 'react'
ReactDOM = require 'react-dom'
{ createHistory } = require 'history'

{ Router, createRoutes } = require './router'
routes = require './routes'
{ createStore } = require './store'

history = createHistory()
store = createStore(window.__INITIAL_STATE__)
routes =  createRoutes(routes, store, document.location.pathname)

App = React.createElement(Router, {routes, history, store})
ReactDOM.render(App, document.getElementById('app'))
