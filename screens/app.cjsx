React = require 'react'
{ connect } = require 'react-redux'
assign = require 'object-assign'

styles =
  app:
    fontFamily: 'Helvetica Neue, Helvetica, Arial, sans-serif'
  list:
    float: 'left'
    marginRight: 100

App = ({contribs, children}) ->
  <div style={styles.app}>
    <div style={styles.list}>
      {
        for contrib in contribs
          <p key={contrib.id}>
            <a href={'/user/' + contrib.login}>{contrib.login}</a>
          </p>
      }
    </div>
    <div>
      {children}
    </div>
  </div>

mapStateToProps = (state) -> contribs: state.contribs
mapDispatchToProps = (dispatch) -> {}
mergeProps = (stateProps, dispatchProps, parentProps) ->
  assign {}, parentProps, stateProps, dispatchProps

module.exports = connect(
  mapStateToProps
  mapDispatchToProps
  mergeProps
)(App)
