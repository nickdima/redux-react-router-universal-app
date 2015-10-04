module.exports = (html, state) ->
  """
    <!doctype html>
    <html>
      <head>
        <title>Redux + React Router Universal Example</title>
      </head>
      <body>
        <div id="app">#{html}</div>
        <script>
          window.__INITIAL_STATE__ = #{JSON.stringify(state)};
        </script>
        <script src="/js/client.js"></script>
      </body>
    </html>
  """
