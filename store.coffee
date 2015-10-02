{ combineReducers, createStore, applyMiddleware } = require 'redux'
promiseMiddleware = require 'redux-promise'

reducers = require './reducers'

createStoreWithMiddleware = applyMiddleware(
  promiseMiddleware
)(createStore)
reducer = combineReducers(reducers)
store = createStoreWithMiddleware(reducer)

module.exports = store
