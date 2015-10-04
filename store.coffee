{ combineReducers, createStore, applyMiddleware } = require 'redux'
promiseMiddleware = require 'redux-promise'
createLogger = require 'redux-logger';

reducers = require './reducers'

logger = createLogger
  predicate: -> typeof window isnt 'undefined'
  logger: console if typeof window is 'undefined'

module.exports =
  createStore: (initialState = {}) ->
    createStoreWithMiddleware = applyMiddleware(
      promiseMiddleware
      logger
    )(createStore)
    reducer = combineReducers(reducers)
    createStoreWithMiddleware(reducer, initialState)
