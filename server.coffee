require('node-cjsx').transform()
express = require 'express'
createLocation = require 'history/lib/createLocation'
React = require 'react'
{ renderToString } = require 'react-dom/server'
{ match } = require 'react-router'
assign = require 'object-assign'

{ RoutingContext, dispatchRouteActions } = require './router'
routes = require './routes'
{createStore} = require './store'
appTemplate = require './templates/app'

app = express()

if process.env.NODE_ENV is 'development'
  webpack = require 'webpack'
  compiler = webpack require './webpack.config.coffee'
  app.use require('webpack-dev-middleware')(compiler, {})

app.get '*', (req, res) ->
  location = createLocation(req.url)
  match { routes, location }, (error, redirectLocation, renderProps) ->
    # no error handling implemented
    return res.send('') if not renderProps?
    store = createStore()
    dispatchRouteActions(renderProps, store).then ->
      props = assign {}, renderProps, {store}
      element = React.createElement(RoutingContext, props)
      html = renderToString(element)
      app = appTemplate(html, store.getState())
      res.send(app)

server = app.listen 9001, ->
  host = server.address().address
  port = server.address().port
  console.log 'Example app listening at http://%s:%s', host, port
