require('node-cjsx').transform()
express = require 'express'
createLocation = require 'history/lib/createLocation'
React = require 'react'
{ renderToString } = require 'react-dom/server'
{ match } = require 'react-router'
Promise = require 'bluebird'

RoutingContext = require './routing-context'
routes = require './routes'
store = require './store'

app = express()

hasAction = (route) -> route.action?

app.get '*', (req, res) ->
  location = createLocation(req.url)
  match { routes, location }, (error, redirectLocation, renderProps) ->
    # no error handling implemented
    promises = renderProps.routes.filter(hasAction).map (route) ->
      action = route.action.call(this, renderProps.params)
      store.dispatch(action)

    Promise.all(promises).then (data) ->
      element = React.createElement(RoutingContext, renderProps)
      html = renderToString(element)
      res.send(html)

server = app.listen 9001, ->
  host = server.address().address
  port = server.address().port
  console.log 'Example app listening at http://%s:%s', host, port
