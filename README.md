# Redux & React Router universal app

A simple example for doing data fetching and rendering in a universal
(aka isomorphic) app with React Router and Redux.

### Setup

Clone the repo then:

```
npm install
npm start
```

### Description

The example uses the GitHub API for demonstrating how async Redux
actions can work together with React Router server side and client
rendering.  
For the sake of simplicity it's also using
[redux-actions](https://github.com/acdlite/redux-actions) and
[redux-promise](https://github.com/acdlite/redux-promise).

These are the most important aspects of this approach:

- **universal**: setting redux actions for data fetching as props on
the routes, as seen [here](https://github.com/nickdima/redux-react-router-universal-app/blob/master/routes.cjsx):

```coffee
<Route path="/" component={App} action={actions.getContribs}>
  <Route path="user/:name" component={User} action={actions.getUser} />
</Route>
```

- **server**: collecting all actions, dispatching them and waiting
for all of them to settle before rendering the matched route server
side, as seen [here](https://github.com/nickdima/redux-react-router-universal-app/blob/master/router.cjsx):

```coffee
dispatchRouteActions: ({routes, params}, store) ->
  actions = for route in routes when route.action?
    store.dispatch route.action.call(this, params)
  Promise.all(actions)

...

dispatchRouteActions(renderProps, store).then ->
  props = assign {}, renderProps, {store}
  element = React.createElement(RoutingContext, props)
  html = renderToString(element)
  app = appTemplate(html, store.getState())
  res.send(app)
```

- **client**: dispatching a route's action when entering it by setting
the `onEnter` prop on every route that has an `action` prop, as seen [here](https://github.com/nickdima/redux-react-router-universal-app/blob/master/router.cjsx):

```coffee
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

...

routes =  createRoutes(routes, store, document.location.pathname)
```

### Troubleshooting

- if data is not loading anymore it's possible you exceeded GitHub's
API rate limit of 60 calls/hour
