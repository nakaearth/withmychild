const path = require('path');

module.exports = {
  watch: true,
  entry: path.resolve(__dirname, 'client/src/index.js'),
  output: {
    path: path.resolve(__dirname, 'app/assets/javascripts/webpack'),
    filename: '[name].js',
  },
  module: {
    rules: [
      {
        test: /\.js(x)$/,
        use: [
          {
             loader: "babel-loader",
             options: {
               presets: ['env', 'react']
             }
          }
        ],
        exclude: /node_modules/,
      },
    ]
  },
  resolve: {
    extensions: ['.js', '.jsx'],
  },
};
