/*
 * Tencent is pleased to support the open source community by making BK-CI 蓝鲸持续集成平台 available.
 *
 * Copyright (C) 2019 THL A29 Limited, a Tencent company.  All rights reserved.
 *
 * BK-CI 蓝鲸持续集成平台 is licensed under the MIT license.
 *
 * A copy of the MIT License is included in this file.
 *
 *
 * Terms of the MIT License:
 * ---------------------------------------------------
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

const path = require('path')
const webpack = require('webpack')
const cssExtractPlugin = require('mini-css-extract-plugin')
const CopyWebpackPlugin = require('copy-webpack-plugin')
const htmlWebpackPlugin = require('html-webpack-plugin')
const VueLoaderPlugin = require('vue-loader/lib/plugin')
const BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin
const TerserPlugin = require('terser-webpack-plugin')

module.exports = (env, argv) => {
    const nodeEnv = process.env.NODE_ENV || 'dev'
    const envPrefix = env && env.prefix ? env.prefix : nodeEnv
    const publicPath = '/environment/'
    const isMaster = envPrefix === 'master'
    return {
        devtool: 'source-map',
        entry: {
            environment: './src/index'
        },
        output: {
            publicPath,
            chunkFilename: isMaster ? '[name].[chunkhash].js' : '[name].js',
            filename: isMaster ? '[name].[contentHash].min.js' : '[name].js'
        },
        module: {
            rules: [
                {
                    test: /\.vue$/,
                    include: [path.resolve('src'), path.resolve('node_modules/vue-echarts')],
                    loader: 'vue-loader'
                },
                {
                    test: /\.js$/,
                    include: [path.resolve('src'), path.resolve('node_modules/vue-echarts')],
                    use: [
                        {
                            loader: 'babel-loader'
                        }
                    ]
                },
                {
                    test: /.scss$/,
                    use: [cssExtractPlugin.loader, 'css-loader', 'sass-loader']
                },
                {
                    test: /\.css$/,
                    use: [
                        'vue-style-loader',
                        {
                            loader: 'css-loader'
                        }
                    ]
                },
                {
                    test: /\.(png|jpe?g|gif|svg)(\?.*)?$/,
                    loader: 'url-loader'
                },
                {
                    test: /\.(js|vue)$/,
                    loader: 'eslint-loader',
                    enforce: "pre",
                    include: [path.resolve('src')],
                    exclude: /node_modules/,
                    options: {
                        fix: true,
                        formatter: require('eslint-friendly-formatter')
                    }
                }
            ]
        },
        plugins: [
            new VueLoaderPlugin(),
            new webpack.optimize.LimitChunkCountPlugin({
                // maxChunks: 5, // 必须大于或等于 1
                minChunkSize: 1000
            }),
            new webpack.HashedModuleIdsPlugin(),
            new cssExtractPlugin({
                filename: isMaster ? '[name].[chunkHash].css' : '[name].css',
                chunkName: '[id].css'
            })
            
        ],
        optimization: {
            namedChunks: true,
            minimizer: [
                new TerserPlugin({
                  cache: true,
                  parallel: true,
                  sourceMap: true, // Must be set to true if using source-maps in production
                  terserOptions: {
                    output: {
                        comments: false
                    },
                    compress: {
                        drop_console: true
                    }
                  }
                })
            ]
        },
        resolve: {
            extensions: ['.js', '.vue', '.json'],
            alias: {
                '@': path.resolve('src'),
                'vue$': 'vue/dist/vue.esm.js'
            }
        },
        externals: {
            'vue': 'Vue',
            'vue-router': 'VueRouter',
            'vuex': 'Vuex'
        },
        devServer: {
            contentBase: path.join(__dirname, 'dist'),
            historyApiFallback: true,
            noInfo: false,
            disableHostCheck: true,
            port: 8001
        }
    }
}
