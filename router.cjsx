React = require 'react'
{ Router, RoutingContext, createRoutes } = require 'react-router'
{ Provider } = require 'react-redux'
Promise = require 'bluebird'
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
    dispatchAction = ({location: {pathname}, params}) ->
      if pathname isnt currentPathname
        store.dispatch @action.call(this, params)
      currentPathname = pathname

    createRoutes(routes).map set = (route) ->
      {action, onEnter, childRoutes} = route
      onEnter ?= dispatchAction if action?
      childRoutes = childRoutes?.map(set)
      assign {}, route, {onEnter, childRoutes}

  dispatchRouteActions: ({routes, params}, store) ->
    actions = for route in routes when route.action?
      store.dispatch route.action.call(this, params)
    Promise.all(actions)
