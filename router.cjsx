React = require 'react'
{ Router, RoutingContext, createRoutes } = require 'react-router'
{ Provider } = require 'react-redux'
assign = require 'object-assign'

module.exports =
  RoutingContext: (props) ->
    <Provider store={props.store}>
      <RoutingContext {...props} />
    </Provider>

  Router: (props) ->
    <Provider store={props.store}>
      <Router {...props} />
    </Provider>

  createRoutes: (routes, store, currentPathname) ->
    onRouteEnter = ({location: {pathname}, params}) ->
      if pathname isnt currentPathname
        store.dispatch @action.call(this, params)
      currentPathname = pathname

    createRoutes(routes).map set = (route) ->
      newRoute = assign({}, route)
      {action, onEnter, childRoutes} = newRoute
      if action? and not onEnter?
        newRoute.onEnter = onRouteEnter
      if childRoutes?
        newRoute.childRoutes = childRoutes.map(set)
      newRoute
