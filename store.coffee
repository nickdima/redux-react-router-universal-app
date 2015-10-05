{ combineReducers, compose, createStore, applyMiddleware } = require 'redux'
promiseMiddleware = require 'redux-promise'
createLogger = require 'redux-logger'
reducers = require './reducers'

module.exports =
  createStore: (initialState = {}) ->
    middleware = [promiseMiddleware]
    middleware.push(createLogger()) if window?
    storeEnhancer = applyMiddleware.apply(this, middleware)
    reducer = combineReducers(reducers)
    storeEnhancer(createStore)(reducer, initialState)
