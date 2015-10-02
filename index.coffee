require('node-cjsx').transform()
express = require 'express'
createLocation = require 'history/lib/createLocation'
React = require 'react'
{ renderToString } = require 'react-dom/server'
{ RoutingContext, match } = require 'react-router'
{ Provider } = require 'react-redux'
Promise = require 'bluebird'

routes = require './routes'
store = require './store'

app = express()

app.get '*', (req, res) ->
  location = createLocation(req.url)
  match { routes, location }, (error, redirectLocation, renderProps) ->
    # no error handling implemented
    hasAction = (route) -> route.action?
    promises = renderProps.routes.filter(hasAction).map (route) ->
      action = route.action.call(this, renderProps.params)
      store.dispatch(action)

    Promise.all(promises).then (data) ->
      router = React.createElement(RoutingContext, renderProps)
      provider = React.createElement(Provider, {store}, router)
      html = renderToString(provider)
      res.send(html)

server = app.listen 9001, ->
  host = server.address().address
  port = server.address().port
  console.log 'Example app listening at http://%s:%s', host, port
