const path = require('path');
const glob = require('glob');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const TerserPlugin = require('terser-webpack-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const globImporter = require('node-sass-glob-importer');

module.exports = (env, options) => {
  const devMode = options.mode !== 'production';

  return {
    optimization: {
      minimize: true,
      minimizer: [
        new TerserPlugin({ parallel: true }),
        new OptimizeCSSAssetsPlugin({})
      ]
    },
    entry: {
      'application': glob.sync('./vendor/**/*.js').concat(['./js/application.js'])
    },
    output: {
      filename: '[name].js',
      path: path.resolve(__dirname, '../priv/static/js'),
      publicPath: '/js/'
    },
    devtool: devMode ? 'eval-cheap-module-source-map' : undefined,
    module: {
      rules: [
        {
          test: /\.js$/,
          exclude: /node_modules/,
          use: {
            loader: 'babel-loader'
          }
        },
        {
          test: /\.[s]?css$/,
          use: [
            MiniCssExtractPlugin.loader,
            'css-loader',
            'postcss-loader',
            {
              loader: 'sass-loader',
              options: {
                sourceMap: true,
                sassOptions: {
                  importer: globImporter()
                }
              }
            }
          ],
        }
      ]
    },
    plugins: [
      new MiniCssExtractPlugin({ filename: '../css/application.css' }),
      new CopyWebpackPlugin({
        patterns: [{ from: 'static/', to: '../' }]
      })
    ]
  }
};
