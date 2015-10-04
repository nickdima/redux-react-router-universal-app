React = require 'react'
{ connect } = require 'react-redux'
assign = require 'object-assign'

styles =
  user:
    backgroundColor: '#EEE'
    padding: 20
    float: 'left'
    borderRadius: 5
    textAlign: 'center'
  avatar:
    width: 150
    height: 150
    borderRadius: '50%'
  name:
    fontWeight: 'bold'
  location:
    color: '#666'

class User extends React.Component
  componentWillReceiveProps: (nextProps) ->
    # console.log 'componentWillReceiveProps', nextProps

  render: ->
    {user} = @props
    <div style={styles.user}>
      <img style={styles.avatar} src={user.avatar_url} />
      <p style={styles.name}>{user.name}</p>
      <p style={styles.location}>{user.location}</p>
    </div>

mapStateToProps = (state) -> user: state.user
mapDispatchToProps = (dispatch) -> {}
mergeProps = (stateProps, dispatchProps, parentProps) ->
  assign {}, parentProps, stateProps, dispatchProps

module.exports = connect(
  mapStateToProps
  mapDispatchToProps
  mergeProps
)(User)
