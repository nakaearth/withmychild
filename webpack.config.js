module.exports = {
  entry: {
    app: './client/src/index.js',
  },

  output: {
    path: __dirname + '/app/assets/javascripts/webpack/',
    filename: '[name].js',
  },

  module: {
    loaders: [
      { test: /\.(js|jsx)$/,
        loader: "babel-loader",
        exclude: /node_modules/,
        query: {
          presets: ["es2015", "react"],
        }
      },
    ]
  },
}
