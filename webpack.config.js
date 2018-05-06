const path = require('path');
const webpack = require('webpack');

module.exports = {
  watch: true,
  entry: path.resolve(__dirname, 'client/src/index.js'),
  output: {
    path: path.resolve(__dirname, 'app/assets/javascripts/webpack'),
    filename: '[name].js',
  },
  devServer: {
    contentBase: path.resolve(__dirname, 'app/assets/javascripts/webpack'),
    host: '0.0.0.0',
    port: '8080',
    open: true,
  },
  module: {
    rules: [
      {
        test: /\.js(x)$/,
        loader: "babel-loader",
        exclude: /node_modules/,
      },
    ]
  },
  resolve: {
    extensions: ['.js', '.jsx'],
  },
};
