{ handleActions } = require 'redux-actions'

module.exports =

  user: handleActions
    'GET_USER': (state, action) -> action.payload
  , {}

  contribs: handleActions
    'GET_CONTRIBS': (state, action) -> action.payload
  , {}
