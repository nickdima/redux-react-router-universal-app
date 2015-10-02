fetch = require 'node-fetch'
fetch.Promise = require 'bluebird'
{ createAction } = require 'redux-actions'

module.exports =

  getUser: createAction 'GET_USER', ({name}) ->
    url = 'https://api.github.com/users/' + name
    fetch(url).then (res) -> res.json()

  getContribs: createAction 'GET_CONTRIBS', ->
    url = 'https://api.github.com/repos/rackt/react-router/contributors'
    fetch(url).then (res) -> res.json()
