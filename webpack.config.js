const path = require('path');
const webpack = require('webpack');

module.exports = {
  watch: true,
  mode: 'development',
  entry: path.resolve(__dirname, '/client/src/index.js'),
  output: {
    path: path.resolve(__dirname, '/app/assets/javascripts/webpack/'),
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
