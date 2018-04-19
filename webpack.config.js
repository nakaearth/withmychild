const path = require('path');
const webpack = require('webpack');

module.exports = {
  mode: 'development',
  entry: {
    index: [
      path.resolve(__dirname, './client/src/index.js')
    ]
  },

  output: {
    path: __dirname + '/app/assets/javascripts/webpack/',
    filename: '[name].js',
  },

  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        loader: "babel-loader",
        exclude: /node_modules/,
        query: {
          presets: ["es2015", "react"],
        }
      },
    ]
  },
  resolve: {
    extensions: ['.js', '.jsx'],
  },
};
