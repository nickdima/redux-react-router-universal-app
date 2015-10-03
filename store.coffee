{ combineReducers, createStore, applyMiddleware } = require 'redux'
promiseMiddleware = require 'redux-promise'

reducers = require './reducers'

module.exports =
  createStore: ->
    createStoreWithMiddleware = applyMiddleware(
      promiseMiddleware
    )(createStore)
    reducer = combineReducers(reducers)
    createStoreWithMiddleware(reducer)
