# Redux & React Router server rendering

A simple example for doing data fetching and server side rendering with React Router and Redux

### Setup

Clone the repo then:

```
npm install
npm start
```

### Description

The example uses the GitHub API for demonstrating how async Redux
actions can work together with React Router server side rendering.
For the sake of simplicity it's also using
[redux-actions](https://github.com/acdlite/redux-actions) and
[redux-promise](https://github.com/acdlite/redux-promise).

The most important aspects of this approach are these:

- setting redux actions for data fetching as props on the routes, as
seen [here](https://github.com/nickdima/redux-react-router-server/blob/master/routes.cjsx#L9):

```coffee
<Route path="/" component={App} action={actions.getContribs}>
  <Route path="user/:name" component={User} action={actions.getUser} />
</Route>
```

- collecting all actions, dispatching them and waiting for all of them to settle before rendering the matched route server side, as seen [here](https://github.com/nickdima/redux-react-router-server/blob/master/index.coffee#L21):

```coffee
promises = renderProps.routes.filter(hasAction).map (route) ->
  action = route.action.call(this, renderProps.params)
  store.dispatch(action)

Promise.all(promises).then (data) ->
  element = React.createElement(RoutingContext, renderProps)
  html = renderToString(element)
  res.send(html)
```

### Troubleshooting

- if data is not loading anymore it's possible you exceeded GitHub's API rate
limit of 60 calls/hour
