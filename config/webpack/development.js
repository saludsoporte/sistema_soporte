process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')
const webpack = require('webpack')
environment.plugins.prepend('Provide',
    new webpack.ProvidePlugin({
        $: 'jquery/src/jquery',
        jquery: 'jquery/src/jquery',
        jQuery: 'jquery/src/jquery',
        selectize: '?'
    })
)
module.exports = environment.toWebpackConfig()