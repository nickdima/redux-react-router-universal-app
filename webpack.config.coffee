# webpack.config.coffee
webpack = require 'webpack'

module.exports =
  context: __dirname

  entry:
    client: ['./client.coffee']

  output:
    path: __dirname + "/build"
    filename: 'js/[name].js'

  resolve:
    modulesDirectories: ['web_modules', 'node_modules']
    extensions: ['', '.webpack.js', '.web.js', '.js', '.coffee', '.cjsx']

  module:
    loaders: [
      # Source code transforms
      {test: /\.cjsx$/, loaders: ['coffee', 'cjsx']}
      {test: /\.coffee$/, loader: 'coffee'}
      {test: /\.json$/, loader: 'json'}
    ]

  devtool: 'source-map'
